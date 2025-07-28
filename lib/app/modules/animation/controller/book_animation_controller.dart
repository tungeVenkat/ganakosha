import 'package:garuda/app/routes/app_routes.dart';
import 'package:get/get.dart';

class BookAnimationController extends GetxController {
  // No controller logic needed yet unless we add more interactivity later
  void navigateToDonorEntry() {
    Get.toNamed(AppRoutes.DONOR_ENTRY);
  }
}
