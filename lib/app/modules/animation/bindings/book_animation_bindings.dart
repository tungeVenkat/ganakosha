import 'package:garuda/app/modules/animation/controller/book_animation_controller.dart';
import 'package:get/get.dart';

class BookAnimationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookAnimationController>(() => BookAnimationController());
  }
}
