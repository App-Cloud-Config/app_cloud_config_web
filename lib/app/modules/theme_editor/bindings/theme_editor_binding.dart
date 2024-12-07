import 'package:get/get.dart';

import '../controllers/theme_editor_controller.dart';

class ThemeEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeEditorController>(
      () => ThemeEditorController(),
    );
  }
}
