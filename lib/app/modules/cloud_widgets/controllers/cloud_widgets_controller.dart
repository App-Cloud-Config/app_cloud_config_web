import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:app_cloud_config_web/app/core/api/endpoints.dart';
import 'package:app_cloud_config_web/app/core/enums/cloud_widgets.dart';
import 'package:app_cloud_config_web/app/core/extension/string_extension.dart';
import 'package:app_cloud_config_web/app/data/dto/cloud_widgets/cloud_sizedbox_widget_dto.dart';
import 'package:app_cloud_config_web/app/data/dto/cloud_widgets/cloud_text_widget_dto.dart';
import 'package:app_cloud_config_web/app/modules/cloud_widgets/controllers/list_widget_controller.dart';
import 'package:app_cloud_config_web/dependency_injection.dart';
import 'package:app_cloud_config_web/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CloudWidgetController extends GetxController {
  RxString selectedWidgetType = CloudWidgets.Text.name.obs;
  RxString editWidgetId = ''.obs;

  // Widget properties
  Rx<CloudTextWidgetDto?> textWidgetProperties = Rx<CloudTextWidgetDto?>(null);
  Rx<CloudSizedBoxWidgetDto?> sizedBoxWidgetProperties =
      Rx<CloudSizedBoxWidgetDto?>(null);

// Function to update the Text widget properties
  void updateTextWidgetProperties({
    String? text,
    String? fontSize,
    String? fontWeight,
    String? fontStyle,
    String? textAlign,
    String? overflow,
    String? maxLines,
    String? widgetId,
  }) {
    // Initialize textWidgetProperties if it's null
    textWidgetProperties.value =
        textWidgetProperties.value ?? CloudTextWidgetDto();

    // Update the properties
    textWidgetProperties.value = textWidgetProperties.value!.copyWith(
      text: text ?? textWidgetProperties.value?.text,
      fontSize: fontSize ?? textWidgetProperties.value?.fontSize,
      fontWeight: fontWeight ?? textWidgetProperties.value?.fontWeight,
      fontStyle: fontStyle ?? textWidgetProperties.value?.fontStyle,
      textAlign: textAlign ?? textWidgetProperties.value?.textAlign,
      overflow: overflow ?? textWidgetProperties.value?.overflow,
      maxLines: maxLines ?? textWidgetProperties.value?.maxLines,
    );
  }

  // Function to update the SizedBox widget properties
  void updateSizedBoxWidgetProperties({
    String? width,
    String? height,
  }) {
    // Initialize sizedBoxWidgetProperties if it's null
    sizedBoxWidgetProperties.value =
        sizedBoxWidgetProperties.value ?? CloudSizedBoxWidgetDto();

    // Update the properties
    sizedBoxWidgetProperties.value = sizedBoxWidgetProperties.value!.copyWith(
      width: width ?? sizedBoxWidgetProperties.value?.width,
      height: height ?? sizedBoxWidgetProperties.value?.height,
    );
  }

  Future<void> saveWidget() async {
    Get.showOverlay(
        asyncFunction: () async {
          final widgetType = CloudWidgets.values.firstWhere(
            (e) => e.name == selectedWidgetType.value,
            orElse: () => CloudWidgets.Text,
          );

          // Generate unique widget ID
          final widgetId = editWidgetId.value != ''
              ? editWidgetId.value
              : "${widgetType.name.toLowerCase()}_${_generateUniqueId()}";

          // Build the widget parameter
          Map<String, dynamic> widgetParameters = {};
          if (widgetType == CloudWidgets.Text) {
            if (textWidgetProperties.value == null) {
              'Text widget properties are missing'.showToast(ToastType.error);
              return;
            }
            widgetParameters = textWidgetProperties.value!.toJson();
          } else if (widgetType == CloudWidgets.SizedBox) {
            if (sizedBoxWidgetProperties.value == null) {
              'SizedBox widget properties are missing'
                  .showToast(ToastType.error);
              return;
            }
            widgetParameters = sizedBoxWidgetProperties.value!.toJson();
          }

          log(widgetId.toString());
          final body = {
            "groupName": "widgets",
            "parameters": {
              widgetId: jsonEncode({
                "widgetType": widgetType.name,
                "widgetId": widgetId,
                ...widgetParameters,
              }),
            },
          };

          try {
            // Retrieve the token from SharedPreferences
            String? token = sharedPreferences.getString('token');

            // Check if the token exists
            if (token == null) {
              'Token not found. Please log in again.'
                  .showToast(ToastType.error);
              return;
            }

            // Prepare the request headers with the token
            final headers = {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            };
            log(body.toString());
            // API Call
            final dio = locator<Dio>();
            final response = await dio.post(
              Endpoints.setData,
              data: body,
              options: Options(headers: headers),
            );

            if (response.statusCode == 200) {
              'Widget saved successfully'.showToast(ToastType.success);
              Get.find<WidgetListController>().fetchWidgets(forceUpdate: true);
              sizedBoxWidgetProperties.value = CloudSizedBoxWidgetDto();
              textWidgetProperties.value = CloudTextWidgetDto();
              editWidgetId.value = '';
              update();
            } else {
              'Failed to save widget: ${response.data}'
                  .showToast(ToastType.error);
            }
          } catch (e, stackTrace) {
            if (e is DioException) {
              log(e.toString());
            }
            debugPrintStack(stackTrace: stackTrace);
            'Error saving widget: $e'.showToast(ToastType.error);
          }
        },
        loadingWidget: const Center(
          child: CircularProgressIndicator.adaptive(),
        ));
  }

  // Utility to generate unique IDs
  String _generateUniqueId({int length = 5}) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    math.Random random = math.Random();

    // Generate a random alphanumeric string with the specified length
    String uniqueId = List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();

    return uniqueId;
  }
}
