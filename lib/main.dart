  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:garuda/app/routes/app_pages.dart';
  import 'package:garuda/app/routes/app_routes.dart';
  import 'package:get/get_navigation/src/root/get_material_app.dart';
  import 'package:get_storage/get_storage.dart';

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(GetMaterialApp(
    title: 'GARUDA',
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.SPLASH,
    getPages: AppPages.routes,
  ));
}


  // class MyApp extends StatelessWidget {
  //   @override
  //   Widget build(BuildContext context) {
  //     return GetMaterialApp(
  //       title: 'GARUDA',
  //       initialRoute: AppRoutes.SPLASH,
  //       getPages: AppPages.routes,
  //       debugShowCheckedModeBanner: false,
  //     );
  //   }
  // }
