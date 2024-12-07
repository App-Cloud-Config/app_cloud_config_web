import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../main.dart';
import '../modules/cloud_widgets/bindings/cloud_widgets_binding.dart';
import '../modules/cloud_widgets/views/cloud_widgets_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/theme_editor/bindings/theme_editor_binding.dart';
import '../modules/theme_editor/views/theme_editor_view.dart';
import '../modules/upload_credentials/bindings/upload_credentials_binding.dart';
import '../modules/upload_credentials/views/upload_credentials_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.THEME_EDITOR,
      page: () => const ThemeEditorView(),
      binding: ThemeEditorBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_CREDENTIALS,
      page: () => const UploadCredentialsView(),
      binding: UploadCredentialsBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CLOUD_WIDGETS,
      page: () => const CloudWidgetsView(),
      binding: CloudWidgetsBinding(),
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings redirect(String? route) {
    String? token = sharedPreferences.getString('token');
    // Token found, navigate to Theme Editor
    if (token == null) {
      return const RouteSettings(name: Routes.UPLOAD_CREDENTIALS);
    }
    return const RouteSettings(name: Routes.DASHBOARD);
  }
}
