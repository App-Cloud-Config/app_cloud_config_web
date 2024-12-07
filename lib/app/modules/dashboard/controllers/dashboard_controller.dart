import 'package:app_cloud_config_web/app/modules/cloud_widgets/views/cloud_widgets_view.dart';
import 'package:app_cloud_config_web/app/modules/theme_editor/views/theme_editor_view.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    const ThemeEditorView(),
    const CloudWidgetsView(),
  ];
}
