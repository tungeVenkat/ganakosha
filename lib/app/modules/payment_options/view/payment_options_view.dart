import 'package:flutter/material.dart';
import 'package:garuda/app/modules/donor_entry/donor_model.dart';
import 'package:get/get.dart';
import '../controller/payment_options_controller.dart';

class PaymentOptionsView extends GetView<PaymentOptionsController> {
  final DonorModel donor;

  const PaymentOptionsView({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.volunteer_activism,
              size: 40, color: Colors.deepOrange),
          const SizedBox(height: 8),
          const Text(
            "-: Select Payment Mode :-",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _paymentButton(
            Icons.qr_code_scanner,
            "Scan UPI QR",
            () {
              Get.back(); // 👈 First close this dialog
              Future.delayed(Duration(milliseconds: 300), () {
                controller.handleQR(donor); // 👈 Then open QR popup
              });
            },
          ),
          _paymentButton(Icons.money, "Cash Payment", controller.handleCash),
        ],
      ),
    );
  }

  Widget _paymentButton(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: Icon(icon, size: 22, color: Colors.white),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () {
            onTap();
            Get.back(); // close dialog after selection
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
      ),
    );
  }
}
