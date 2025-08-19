import 'package:flutter/widgets.dart';
import 'package:garuda/app/modules/donor_entry/donor_model.dart';
import 'package:garuda/app/modules/qr_payment/view/qr_payment_view.dart';
import 'package:get/get.dart';
import 'package:garuda/app/modules/donor_entry/controller/donor_entry_controller.dart';

class PaymentOptionsController extends GetxController {
  final DonorEntryController donorController = Get.find<DonorEntryController>();
  int? donorIndex;
  bool _isQRDialogOpen = false;

  void handleQR(DonorModel donor) {
    if (_isQRDialogOpen) return;
    _isQRDialogOpen = true;

    Get.dialog(
      QRPaymentPopup(
        donor: donor,
        onClose: () {
          _isQRDialogOpen = false;
        },
      ),
      barrierDismissible: false,
    );
  }

  void handleCash() {
    if (donorIndex == null) {
      print("❌ Error: donorIndex not set");
      return;
    }

    // Trigger payment and save to Firestore
    donorController.pay(donorIndex!);

    // Close the popup and return to entry screen
    Get.back();

    Get.snackbar(
      "Success",
      "Donation marked as PAID ✅",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.theme.primaryColor,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
    );

    print("💰 Cash payment recorded for donor at index $donorIndex");
  }
}
