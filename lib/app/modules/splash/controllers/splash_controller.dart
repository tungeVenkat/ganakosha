import 'package:get/get.dart';
import 'dart:async';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('🔃 SplashController initialized');
    Timer(Duration(seconds: 3), () {
      print('⏳ Splash done, navigating to animation...');
      Get.offNamed(AppRoutes.ANIMATION);
    });
  }
}

