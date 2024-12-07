import 'package:flutter/material.dart';
import 'package:app_cloud_config_web/app/modules/theme_editor/controllers/theme_editor_controller.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ThemeEditorView extends GetView<ThemeEditorController> {
  const ThemeEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      autoRemove: false,
      init: ThemeEditorController(),
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Web Theme Editor"),
              bottom: TabBar(
                tabs: const [
                  Tab(icon: Icon(Icons.wb_sunny), text: "Light Mode"),
                  Tab(icon: Icon(Icons.nights_stay), text: "Dark Mode"),
                ],
                onTap: controller.onTabChange,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Edit ${controller.selectedMode.capitalizeFirst} Mode",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Icon(
                        controller.selectedMode == "light"
                            ? Icons.wb_sunny
                            : Icons.nights_stay,
                        color: controller.selectedMode == "light"
                            ? Colors.yellow
                            : Colors.grey.shade600,
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  controller.obx(
                    onEmpty: const Text('EMPTY'),
                    onError: (e) => Center(
                      child: Text(e.toString()),
                    ),
                    onLoading: Expanded(
                        child: Skeletonizer(
                      enabled: true,
                      child: ListView(
                        children: List.generate(
                          10,
                          (index) => ListTile(
                            tileColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            title: const Text(
                              'TESTING DUMMY DATA FOR LOADING',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing:
                                const Icon(Icons.edit, color: Colors.grey),
                          ),
                        ),
                      ),
                    )),
                    (state) => Expanded(
                      child: ListView(
                        children: controller
                            .themeColors[controller.selectedMode]!.keys
                            .map((property) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: controller.themeColors[
                                      controller.selectedMode]![property],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              title: Text(
                                property.capitalizeFirst!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing:
                                  const Icon(Icons.edit, color: Colors.grey),
                              onTap: () =>
                                  controller.pickColor(property, context),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
