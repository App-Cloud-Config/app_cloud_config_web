import 'dart:developer';

import 'package:app_cloud_config_web/app/core/api/endpoints.dart';
import 'package:app_cloud_config_web/app/core/extension/string_extension.dart';
import 'package:app_cloud_config_web/app/data/dto/cloud_widgets/widget_dto.dart';
import 'package:app_cloud_config_web/dependency_injection.dart';
import 'package:app_cloud_config_web/main.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WidgetListController extends GetxController with StateMixin {
  List<WidgetModel> widgets = [];

  @override
  Future<void> onReady() async {
    super.onReady();
    await fetchWidgets(); // Fetch widgets when the controller is ready
  }

  Future<void> fetchWidgets({bool forceUpdate = false}) async {
    if (!forceUpdate) {
      change(null, status: RxStatus.loading()); // Set loading state
    }
    try {
      // Retrieve the token from SharedPreferences
      String? token = sharedPreferences.getString('token');

      // Check if the token exists
      if (token == null) {
        'Token not found. Please log in again.'.showToast(ToastType.error);
        return;
      }

      // Prepare the request headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      // Fetch data from API
      final response = await locator<Dio>().get(
        Endpoints.getAllWidgets,
        options: Options(headers: headers),
      );
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        var data = response.data;

        // Ensure the 'widgets' key exists and is a Map
        if (data is Map<String, dynamic> && data.containsKey('widgets')) {
          var widgetsMap = data['widgets'];

          // Check if 'widgets' is a Map
          if (widgetsMap is Map<String, dynamic>) {
            if (widgets.isEmpty) {
              change(null, status: RxStatus.empty());
            }
            // Now map through the 'widgets' Map and process the widget data
            widgets = widgetsMap.entries.map((entry) {
              // Here entry.value is the widget data, which is a Map
              return WidgetModel.fromJson(entry.value as Map<String, dynamic>);
            }).toList();

            update(); // Update the UI with the widget list
            change(null, status: RxStatus.success());
          } else {
            change(null, status: RxStatus.empty());
          }
        } else {
          change(null, status: RxStatus.empty());

          // throw Exception("The 'widgets' field is missing or invalid.");
        }
      } else {
        change(null, status: RxStatus.empty());

        // throw Exception("Error fetching widgets: ${response.data}");
      }
    } catch (e) {
      log('Error: $e');
      // Handle error here
      change(null, status: RxStatus.empty());
    }
  }
}
