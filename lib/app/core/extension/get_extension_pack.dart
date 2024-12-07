import 'package:get/get.dart';

extension GetXControllerExtension on GetInterface {
  T findOrPut<T extends GetxController>(T Function() builder) {
    // Check if the controller is already registered
    if (Get.isRegistered<T>()) {
      return Get.find<T>(); // If registered, find and return it
    } else {
      return Get.put<T>(builder()); // If not, put and return it
    }
  }
}
