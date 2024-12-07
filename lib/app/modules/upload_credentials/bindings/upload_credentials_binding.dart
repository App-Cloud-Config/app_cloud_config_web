import 'package:get/get.dart';

import '../controllers/upload_credentials_controller.dart';

class UploadCredentialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadCredentialsController>(
      () => UploadCredentialsController(),
    );
  }
}
