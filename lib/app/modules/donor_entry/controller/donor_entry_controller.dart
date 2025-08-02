import 'package:flutter/material.dart';
import 'package:garuda/app/modules/donor_entry/donor_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorEntryController extends GetxController {
  var donorList = <DonorModel>[].obs;
  var filteredDonorList = <DonorModel>[].obs;

  var isSaving = false.obs;
  var isSearching = false.obs;
  final searchController = TextEditingController();
  // For search result

  final CollectionReference donorCollection =
      FirebaseFirestore.instance.collection('donors');

  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDonorsFromFirestore();
  }

  // 🔎 Toggle search mode
  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      filteredDonorList.assignAll(donorList);
    }
  }

  // 🔍 Filter donor list
  void filterDonors(String query) {
    if (query.trim().isEmpty) {
      filteredDonorList.assignAll(donorList);
    } else {
      filteredDonorList.assignAll(
        donorList.where((donor) {
          return (donor.name?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (donor.mobile?.contains(query) ?? false);
        }).toList(),
      );
    }
  }

  // 💰 Total amount (regardless of paid/unpaid)
  int get totalAmount =>
      donorList.fold(0, (sum, d) => sum + (int.tryParse(d.amount ?? '0') ?? 0));

  // ✅ Collected amount (paid only)
  int get collectedAmount => donorList
      .where((d) => d.isPaid == true)
      .fold(0, (sum, d) => sum + (int.tryParse(d.amount ?? '0') ?? 0));

  // 📍 Remaining amount
  int get amountToCollect => totalAmount - collectedAmount;

  // 🗑️ Delete donor
  Future<void> deleteDonorFromFirestore(String donorId) async {
    await donorCollection.doc(donorId).delete();
    donorList.removeWhere((d) => d.id == donorId);
    filteredDonorList.assignAll(donorList);
  }

  // 💾 Save new donor
  Future<void> saveDonorToFirestore(DonorModel donor) async {
    if (isSaving.value) return;

    isSaving.value = true;
    try {
      String docId = "${donor.receiptNo}_${donor.mobile}".replaceAll(' ', '_');

      await donorCollection.doc(docId).set(donor.toJson());
      donor.id = docId;

      print("✅ Donor saved to Firestore with ID: $docId");

      // Refresh lists
      int index = donorList.indexWhere((d) => d.id == docId);
      if (index == -1) {
        donorList.add(donor);
      } else {
        donorList[index] = donor;
      }
      filteredDonorList.assignAll(donorList);
    } catch (e) {
      print("❌ Error saving donor: $e");
    } finally {
      isSaving.value = false;
    }
  }

  // ⬇️ Load all donors from Firestore
  void loadDonorsFromFirestore() async {
    try {
      final snapshot = await donorCollection.get();
      final donors = snapshot.docs.map((doc) {
        return DonorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      donorList.assignAll(donors);
      filteredDonorList.assignAll(donors); // Sync search list
    } catch (e) {
      print("❌ Error loading donors: $e");
    }
  }

  // ➕ Add a new donor (in UI only)
  void addNewDonor() {
    int receiptNo = donorList.length + 1;
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

    donorList.add(
      DonorModel(
        receiptNo: receiptNo.toString().padLeft(3, '0'),
        date: date,
        name: '',
        mobile: '',
        amount: '',
      ),
    );
    currentIndex.value = donorList.length - 1;
    filteredDonorList.assignAll(donorList);
  }

  // ✏️ Update donor from controller values (optional)
  void updateDonor(int index) {
    final donor = donorList[index];
    donor.nameController.text = donor.nameController.text;
    donor.mobileController.text = donor.mobileController.text;
    donor.amountController.text = donor.amountController.text;
    donorList.refresh();
    filteredDonorList.refresh();
  }

  // 💰 Mark donor as paid and save
  Future<void> pay(int index) async {
    final donor = donorList[index];

    donor.name = donor.nameController.text;
    donor.mobile = donor.mobileController.text;
    donor.amount = donor.amountController.text;
    donor.isPaid = true;

    await saveDonorToFirestore(donor);

    print("✅ Payment done & donor saved: ${donor.name}");
  }
}
