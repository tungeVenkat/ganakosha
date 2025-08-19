import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Use permanent Put for initial route
    Get.put(SplashController(), permanent: true);
  }
}
