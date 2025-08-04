import 'package:get/get.dart';
import '../../donor_entry/donor_model.dart';

class QRPaymentController extends GetxController {
  final DonorModel donor;

  QRPaymentController(this.donor);

  void markAsPaid() {
    donor.isPaid = true;
    Get.back(); // return to donor entry screen
  }
}
