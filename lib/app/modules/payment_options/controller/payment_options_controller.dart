import 'package:get/get.dart';
import 'package:garuda/app/modules/donor_entry/controller/donor_entry_controller.dart';

class PaymentOptionsController extends GetxController {
  final DonorEntryController donorController = Get.find<DonorEntryController>();
  int? donorIndex;
  void handleQR() {
    // Navigate to QR Scan page (to be implemented next)
    print("QR option clicked");
    if (donorIndex != null) {
      donorController.pay(donorIndex!);
    }
  }

  void handleUPI() {
    // Trigger UPI intent or logic
    print("UPI option clicked");
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
