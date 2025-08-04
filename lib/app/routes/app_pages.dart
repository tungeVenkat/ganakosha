import 'package:garuda/app/modules/animation/bindings/book_animation_bindings.dart';
import 'package:garuda/app/modules/animation/views/book_animation.dart';
import 'package:garuda/app/modules/donor_entry/bindings/donor_entry_binding.dart';
import 'package:garuda/app/modules/donor_entry/donor_model.dart';
import 'package:garuda/app/modules/donor_entry/view/donor_entry_view.dart';
import 'package:garuda/app/modules/payment_options/binding/payment_options_binding.dart';
import 'package:garuda/app/modules/payment_options/view/payment_options_view.dart';
import 'package:garuda/app/modules/qr_payment/binding/qr_payment_binding.dart';
import 'package:garuda/app/modules/qr_payment/controller/qr_payment_controller.dart';
import 'package:garuda/app/modules/qr_payment/view/qr_payment_view.dart';
import 'package:garuda/app/modules/splash/bindings/splash_bindings.dart';
import 'package:garuda/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../modules/splash/views/splash_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.ANIMATION,
      page: () => BookAnimationView(),
      binding: BookAnimationBinding(),
    ),
    GetPage(
      name: AppRoutes.DONOR_ENTRY,
      page: () => DonorEntryView(),
      binding: DonorEntryBinding(),
    ),
    GetPage(
      name: AppRoutes.PAYMENT,
      page: () {
        final donor = Get.arguments as DonorModel;
        return PaymentOptionsView(donor: donor);
      },
      binding: PaymentOptionsBinding(),
    ),
   GetPage(
  name: AppRoutes.QR_PAYMENT,
  page: () {
    final donor = Get.arguments as DonorModel;
    return QRPaymentPopup(
      donor: donor,
      onClose: () {}, // 👈 Dummy empty callback
    );
  },
  binding: BindingsBuilder(() {
    final donor = Get.arguments as DonorModel;
    Get.put(QRPaymentController(donor));
  }),
),

  ];
}
