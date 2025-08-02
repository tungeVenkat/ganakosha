import 'package:flutter/material.dart';

class DonorModel {
  String? id;
  String? receiptNo;
  String? date;
  String? name;
  String? mobile;
  String? amount;
  bool isPaid;
  bool isEditable;

  // Text controllers for UI binding
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController amountController;

  DonorModel({
    this.id,
    this.receiptNo,
    this.date,
    this.name,
    this.mobile,
    this.amount,
    this.isPaid = false,
    this.isEditable = true,
  }) {
    nameController = TextEditingController(text: name ?? '');
    mobileController = TextEditingController(text: mobile ?? '');
    amountController = TextEditingController(text: amount ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'receiptNo': receiptNo,
      'date': date,
      'name': name,
      'mobile': mobile,
      'amount': amount,
      'isPaid': isPaid,
    };
  }

  factory DonorModel.fromMap(Map<String, dynamic> map, String id) {
    return DonorModel(
      id: id,
      receiptNo: map['receiptNo'],
      date: map['date'],
      name: map['name'],
      mobile: map['mobile'],
      amount: map['amount'],
      isPaid: map['isPaid'] ?? false,
    );
  }
}
