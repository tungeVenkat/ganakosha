import 'package:get/get.dart';
import '../controller/donor_entry_controller.dart';

class DonorEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorEntryController());
  }
}