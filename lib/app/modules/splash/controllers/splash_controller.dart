import 'package:get/get.dart';
import '../../animation/views/book_animation.dart';
import '../../animation/bindings/book_animation_bindings.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    // Delay navigation by 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      print('⏳ Splash done, navigating...');
      Get.off(() => BookAnimationView(), binding: BookAnimationBinding());
    });
  }
}
