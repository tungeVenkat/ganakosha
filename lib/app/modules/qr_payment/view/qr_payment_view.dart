import 'package:flutter/material.dart';
import 'package:garuda/app/modules/donor_entry/controller/donor_entry_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import '../../donor_entry/donor_model.dart';

class QRPaymentPopup extends StatelessWidget {
  final DonorModel donor;
  final VoidCallback onClose;

  const QRPaymentPopup({
    super.key,
    required this.donor,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final qrData =
        'upi://pay?pa=9652423509@ptsbi&pn=GARUDA&am=${donor.amount}&cu=INR';

    return Dialog(
      backgroundColor: const Color(0xFFFFF8E1),
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.deepOrange.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Text(
              'ధన్యవాదములు',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade600,
                fontFamily: 'NotoSerifTelugu',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Scan to complete your offering',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            // QR Code
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  QrImageView(
                    data: qrData,
                    size: 220,
                    backgroundColor: Colors.white,
                    errorCorrectionLevel: QrErrorCorrectLevel
                        .H, // High to tolerate embedded image
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/garudaaa.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Donor Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Name", donor.name.toString()),
                  const SizedBox(height: 8),
                  _infoRow("Amount", "₹${donor.amount.toString()}"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Buttons Row
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onClose();
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final donorController = Get.find<DonorEntryController>();
                      donorController.markAsPaidById(
                          donor.id!); // 🔹 use controller, not local setState
                      onClose();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Mark Paid'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              "Thank you for your donation!",
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}
