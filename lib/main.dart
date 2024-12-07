import 'package:app_cloud_config_web/dependency_injection.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

late SharedPreferences sharedPreferences;

void main() async {
  sharedPreferences = await SharedPreferences.getInstance();
  initializeDependencies();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    ),
  );
}
