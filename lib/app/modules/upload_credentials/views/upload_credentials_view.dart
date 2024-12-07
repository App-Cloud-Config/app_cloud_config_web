import 'dart:convert';
import 'package:app_cloud_config_web/app/core/components/primary_button%20copy.dart';
import 'package:app_cloud_config_web/app/routes/app_pages.dart';
import 'package:app_cloud_config_web/dependency_injection.dart';
import 'package:app_cloud_config_web/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:app_cloud_config_web/app/core/api/endpoints.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadCredentialsView extends StatelessWidget {
  const UploadCredentialsView({super.key});

  Future<void> _uploadFile(BuildContext context) async {
    try {
      // Pick a JSON file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.bytes != null) {
        final fileBytes = result.files.single.bytes!;
        final jsonObject = json.decode(utf8.decode(fileBytes));

        final response = await locator<Dio>().post(
          Endpoints.createToken, // Base URL is already set in Dio
          data: jsonObject,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if (response.statusCode == 200) {
          final token = response.data['token'];

          await sharedPreferences.setString('token', token);

          // Navigate to ThemeEditorView
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.data}')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.security_rounded,
              size: 80,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              'Upload Your Service Account Credentials',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To access the Theme Editor, please upload your service account JSON file. This file is essential for securely connecting to your backend services and personalizing your app\'s theme.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blueAccent),
                SizedBox(width: 10),
                Text(
                  'How to upload?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Click the "Upload JSON File" button below.'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Select your service account credentials file.'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('The file should be in .json format.'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Once uploaded, the file will be validated.'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('You will be redirected to the Theme Editor.'),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Icon(Icons.help_outline, color: Colors.blueAccent),
                SizedBox(width: 10),
                Text(
                  'Why is this required?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'The credentials file ensures secure authentication and seamless integration with your backend. It is essential for managing and saving theme configurations safely.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                labelText: 'Upload JSON File',
                onPressed: () => _uploadFile(context),
                icon: const Icon(
                  Icons.upload_file,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                        'https://firebase.google.com/support/guides/service-accounts'),
                  );
                },
                icon: const Icon(Icons.link, color: Colors.blueAccent),
                label: const Text(
                  'Need Help? Read Documentation',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
