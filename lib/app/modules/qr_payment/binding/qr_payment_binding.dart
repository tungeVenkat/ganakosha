import 'package:get/get.dart';
import '../../donor_entry/donor_model.dart';
import '../controller/qr_payment_controller.dart';

class QRPaymentBinding extends Bindings {
  final DonorModel donor;

  QRPaymentBinding(this.donor);

  @override
  void dependencies() {
    Get.lazyPut(() => QRPaymentController(donor));
  }
}
