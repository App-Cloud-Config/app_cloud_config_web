import 'package:get/get.dart';

import '../controllers/cloud_widgets_controller.dart';

class CloudWidgetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CloudWidgetController>(
      () => CloudWidgetController(),
    );
  }
}
