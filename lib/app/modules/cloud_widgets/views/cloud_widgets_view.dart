import 'package:app_cloud_config_web/app/modules/cloud_widgets/widgets/dialog.dart';
import 'package:app_cloud_config_web/app/modules/cloud_widgets/widgets/widgets_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cloud_widgets_controller.dart';

class CloudWidgetsView extends GetView<CloudWidgetController> {
  const CloudWidgetsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const WidgetSelectionDialog(),
        ),
        icon: const Icon(Icons.now_widgets_rounded),
        label: const Text(
          'Create a new CloudWidget',
        ),
      ),
      appBar: AppBar(
        title: const Text('CloudWidgetsView'),
        centerTitle: true,
      ),
      body: const WidgetListView(),
    );
  }
}
