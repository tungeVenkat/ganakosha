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
    int currentIndex = donorController.currentIndex.value;

    // Trigger payment and save to Firestore
    donorController.pay(currentIndex);

    // Close the popup and return to entry screen
    Get.back();

    print("💰 Cash payment recorded and donor saved.");
  }
}
