// 📁 controller/donor_entry_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonorEntryController extends GetxController {
  var donorList = <DonorModel>[].obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    addNewDonor();
  }

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
  }

  void updateDonor(int index) {
    final donor = donorList[index];
    donor.nameController.text = donor.nameController.text;
    donor.mobileController.text = donor.mobileController.text;
    donor.amountController.text = donor.amountController.text;
    donorList.refresh();
  }

  void pay(int index) {
    // Simulate payment processing
    print("Payment done for donor: ${donorList[index].nameController.text}");
  }
}


class DonorModel {
  String receiptNo;
  String date;
  TextEditingController nameController;
  TextEditingController mobileController;
  TextEditingController amountController;

  DonorModel({
    required this.receiptNo,
    required this.date,
    required String name,
    required String mobile,
    required String amount,
  })  : nameController = TextEditingController(text: name),
        mobileController = TextEditingController(text: mobile),
        amountController = TextEditingController(text: amount);
}
