import 'package:flutter/material.dart';
import 'package:garuda/app/modules/donor_entry/donor_model.dart';
import 'package:garuda/app/services/sms_service.dart';
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

  void enableEditing(int index) {
    final donor = filteredDonorList[index];
    donor.isEditable = true;

    donorList.refresh(); // refresh both lists to update UI
    filteredDonorList.refresh();
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
      sortDonorsByPaidAndAmount(paidFirst: true);
      filteredDonorList.assignAll(donorList);
    } catch (e) {
      print("❌ Error loading donors: $e");
    }
  }

  // ➕ Add a new donor (in UI only)
  void addNewDonor() {
    int nextReceiptNo = donorList.length + 1 + 1;
    String receiptStr = nextReceiptNo.toString().padLeft(3, '0');
    final newDonor = DonorModel(
      receiptNo: receiptStr, // auto receipt no
      date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      name: '',
      mobile: '',
      amount: '',
      isPaid: false,
      isEditable: true, // allow editing immediately
    );

    donorList.add(newDonor);
    donorList.refresh(); // 🔹 Force UI update for PageView
    filteredDonorList.assignAll(donorList);
    filteredDonorList.refresh(); // 🔹 Force search list update

    // Jump to the newly added donor page
    currentIndex.value = donorList.length - 1;
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

  Future<void> markAsPaidById(String donorId) async {
    try {
      await donorCollection.doc(donorId).update({'isPaid': true});

      // update main list
      int mainIndex = donorList.indexWhere((d) => d.id == donorId);
      String donorName = "";
      if (mainIndex != -1) {
        donorList[mainIndex].isPaid = true;
        donorName = donorList[mainIndex].name.toString();
      }
      donorList.refresh();

      // update filtered list
      int filteredIndex = filteredDonorList.indexWhere((d) => d.id == donorId);
      if (filteredIndex != -1) {
        filteredDonorList[filteredIndex].isPaid = true;
      }
      filteredDonorList.refresh();

      sortDonorsByPaidAndAmount();

      Get.snackbar(
        "Success",
        "$donorName marked as PAID ✅",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print("❌ Error marking as paid: $e");
    }
  }

// 💰 Mark donor as paid and save
  Future<void> pay(int donorIndex) async {
    // Get donor from filtered list (UI is showing this list)
    final donor = filteredDonorList[donorIndex];

    donor.name = donor.nameController.text;
    donor.mobile = donor.mobileController.text;
    donor.amount = donor.amountController.text;
    donor.isPaid = true;

    try {
      if (donor.id != null && donor.id!.isNotEmpty) {
        await donorCollection.doc(donor.id).update({'isPaid': true});
      } else {
        await saveDonorToFirestore(donor);
      }

      // 🔹 Update donorList (main list)
      int mainIndex = donorList.indexWhere((d) => d.id == donor.id);
      if (mainIndex != -1) {
        donorList[mainIndex] = donor;
      }
      donorList.refresh();

      // 🔹 Update filteredDonorList (search list)
      filteredDonorList[donorIndex] = donor;
      filteredDonorList.refresh();

      // 🔹 Re-sort both lists
      sortDonorsByPaidAndAmount();

      // 🔹 Show snackbar for payment confirmation
      Get.snackbar(
        "Success",
        "${donor.name} has been marked as PAID ✅",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      print("✅ Payment done & donor marked as PAID: ${donor.name}");
    } catch (e) {
      print("❌ Error updating payment: $e");
      Get.snackbar(
        "Error",
        "Failed to mark ${donor.name} as paid ❌",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  // 📊 Sort donors by Paid → Unpaid
  // 📊 Sort donors by Paid → Unpaid and then by Amount (descending)
  void sortDonorsByPaidAndAmount({bool paidFirst = true}) {
    donorList.sort((a, b) {
      // Step 1: Paid/Unpaid sorting
      if (a.isPaid && !b.isPaid) return paidFirst ? -1 : 1;
      if (!a.isPaid && b.isPaid) return paidFirst ? 1 : -1;

      // Step 2: Amount sorting (descending)
      int amountA = int.tryParse(a.amount ?? '0') ?? 0;
      int amountB = int.tryParse(b.amount ?? '0') ?? 0;
      return amountB.compareTo(amountA); // Higher first
    });

    filteredDonorList.assignAll(donorList);
    donorList.refresh();
  }
}
