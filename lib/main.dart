import 'package:flutter/material.dart';
import 'package:garuda/app/routes/app_pages.dart';
import 'package:garuda/app/routes/app_routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GARUDA',
      initialRoute: AppRoutes.ANIMATION,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
