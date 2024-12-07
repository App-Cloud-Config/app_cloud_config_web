import 'dart:convert';
import 'dart:developer';
import 'package:app_cloud_config_web/app/core/api/endpoints.dart';
import 'package:app_cloud_config_web/app/core/extension/string_extension.dart';
import 'package:app_cloud_config_web/app/data/dto/theme_dto/theme_dto.dart';
import 'package:app_cloud_config_web/dependency_injection.dart';
import 'package:app_cloud_config_web/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class ThemeEditorController extends GetxController with StateMixin {
  Map<String, Map<String, Color>> themeColors = {
    "light": {
      "light_primary": Colors.blue,
      "light_secondary": Colors.green,
      "light_surface": Colors.white,
      "light_background": Colors.grey[200]!,
      "light_error": Colors.red,
      "light_onPrimary": Colors.white,
      "light_onSecondary": Colors.black,
      "light_onSurface": Colors.black,
      "light_onBackground": Colors.black,
      "light_onError": Colors.white,
    },
    "dark": {
      "dark_primary": Colors.blue[700]!,
      "dark_secondary": Colors.green[700]!,
      "dark_surface": Colors.grey[800]!,
      "dark_background": Colors.black,
      "dark_error": Colors.red[800]!,
      "dark_onPrimary": Colors.white,
      "dark_onSecondary": Colors.white,
      "dark_onSurface": Colors.white,
      "dark_onBackground": Colors.white,
      "dark_onError": Colors.black,
    },
  };

  String selectedMode = "light";

  @override
  Future<void> onReady() async {
    super.onReady();
    await fetchTheme(); // Initial load
  }

  void pickColor(String property, BuildContext context) async {
    Color pickedColor = themeColors[selectedMode]![property]!;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pick a color for $property"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (color) {
              pickedColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await uploadThemeData(
                {
                  property: colorToHex(pickedColor),
                },
              );
              themeColors[selectedMode]![property] = pickedColor;
              update();
              Get.back();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> uploadThemeData(Map<String, String> color) async {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          // Prepare the theme data in the correct structure
          Map<String, dynamic> themeData = {
            "groupName": '${selectedMode}Theme',
            "parameters": color,
          };

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

          log(themeData.toString());

          // Send the theme data to the server
          final response = await locator<Dio>().post(
            Endpoints.setData,
            data: json.encode(themeData), // Send the theme data as JSON
            options: Options(headers: headers),
          );

          log(json.encode(themeData).toString());

          if (response.statusCode == 200) {
            'Theme data saved successfully!'.showToast(ToastType.success);
          } else {
            'Error: ${response.data}'.showToast(ToastType.error);
          }
        } catch (e, s) {
          if (e is DioException) {
            log(e.response?.data.toString() ?? 'No response data');
          }
          log(e.toString(), stackTrace: s);
          'Failed to save theme data: $e'.showToast(ToastType.error);
        }
      },
      loadingWidget: const CircularProgressIndicator.adaptive(),
    );
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  Future<void> fetchTheme({bool forceUpdate = false}) async {
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

      final response = await locator<Dio>().get(
        Endpoints.getData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        ThemeDto theme = ThemeDto.fromJson(response.data);
        log(theme.darkTheme?.light_error ?? '');
        themeColors['light'] = {
          "light_primary": hexToColor(theme.lightTheme?.light_primary) ??
              themeColors['light']!['light_primary']!,
          "light_secondary": hexToColor(theme.lightTheme?.light_secondary) ??
              themeColors['light']!['light_secondary']!,
          "light_surface": hexToColor(theme.lightTheme?.light_surface) ??
              themeColors['light']!['light_surface']!,
          "light_background": hexToColor(theme.lightTheme?.light_background) ??
              themeColors['light']!['light_background']!,
          "light_error": hexToColor(theme.lightTheme?.light_error) ??
              themeColors['light']!['light_error']!,
          "light_onPrimary": hexToColor(theme.lightTheme?.light_onPrimary) ??
              themeColors['light']!['light_onPrimary']!,
          "light_onSecondary":
              hexToColor(theme.lightTheme?.light_onSecondary) ??
                  themeColors['light']!['light_onSecondary']!,
          "light_onSurface": hexToColor(theme.lightTheme?.light_onSurface) ??
              themeColors['light']!['light_onSurface']!,
          "light_onBackground":
              hexToColor(theme.lightTheme?.light_onBackground) ??
                  themeColors['light']!['light_onBackground']!,
          "light_onError": hexToColor(theme.lightTheme?.light_onError) ??
              themeColors['light']!['light_onError']!,
        };
        themeColors['dark'] = {
          "dark_primary": hexToColor(theme.darkTheme?.dark_primary) ??
              themeColors['dark']!['dark_primary']!,
          "dark_secondary": hexToColor(theme.darkTheme?.dark_secondary) ??
              themeColors['dark']!['dark_secondary']!,
          "dark_surface": hexToColor(theme.darkTheme?.dark_surface) ??
              themeColors['dark']!['dark_surface']!,
          "dark_background": hexToColor(theme.darkTheme?.dark_background) ??
              themeColors['dark']!['dark_background']!,
          "dark_error": hexToColor(theme.darkTheme?.dark_error) ??
              themeColors['dark']!['dark_error']!,
          "dark_onPrimary": hexToColor(theme.darkTheme?.dark_onPrimary) ??
              themeColors['dark']!['dark_onPrimary']!,
          "dark_onSecondary": hexToColor(theme.darkTheme?.dark_onSecondary) ??
              themeColors['dark']!['dark_onSecondary']!,
          "dark_onSurface": hexToColor(theme.darkTheme?.dark_onSurface) ??
              themeColors['dark']!['dark_onSurface']!,
          "dark_onBackground": hexToColor(theme.darkTheme?.dark_onBackground) ??
              themeColors['dark']!['dark_onBackground']!,
          "dark_onError": hexToColor(theme.darkTheme?.dark_onError) ??
              themeColors['dark']!['dark_onError']!,
        };
        update();
        change(null, status: RxStatus.success());
      } else {
        'Error fetching theme data: ${response.data}'
            .showToast(ToastType.error);
        change(null, status: RxStatus.error('Error fetching theme data'));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      'Failed to fetch theme data: $e'.showToast(ToastType.error);
      change(null, status: RxStatus.error('Failed to fetch theme data'));
    }
  }

  Color? hexToColor(String? hexCode) {
    if (hexCode != null && hexCode.isNotEmpty) {
      // Remove '#' if it exists
      hexCode = hexCode.replaceAll('#', '');

      // If the hex code is 6 characters long (RGB), add 'FF' for full opacity
      if (hexCode.length == 6) {
        hexCode = 'FF$hexCode'; // Adding full opacity
      }

      return Color(int.parse('0x$hexCode'));
    }
    return null;
  }

  onTabChange(int index) {
    selectedMode = index == 0 ? "light" : "dark";
    update();
  }
}
