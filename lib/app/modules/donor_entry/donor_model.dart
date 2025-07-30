import 'package:flutter/material.dart';

class DonorModel {
  String receiptNo;
  String date;
  TextEditingController nameController;
  TextEditingController mobileController;
  TextEditingController amountController;
  bool isPaid;

  DonorModel({
    required this.receiptNo,
    required this.date,
    required String name,
    required String mobile,
    required String amount,
    this.isPaid = false,
  })  : nameController = TextEditingController(text: name),
        mobileController = TextEditingController(text: mobile),
        amountController = TextEditingController(text: amount);
}
