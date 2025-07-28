import 'package:get/get.dart';

class PaymentOptionsController extends GetxController {
  void handleQR() {
    // Navigate to QR Scan page (to be implemented next)
    print("QR option clicked");
  }

  void handleUPI() {
    // Trigger UPI intent or logic
    print("UPI option clicked");
  }

  void handleCash() {
    // Mark payment as done
    print("Cash payment recorded");
  }
}
