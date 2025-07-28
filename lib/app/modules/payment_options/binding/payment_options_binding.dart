import 'package:get/get.dart';
import '../controller/payment_options_controller.dart';

class PaymentOptionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentOptionsController>(() => PaymentOptionsController());
  }
}
