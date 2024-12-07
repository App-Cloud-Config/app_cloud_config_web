import 'package:app_cloud_config_web/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController sideBarController = Get.put(DashboardController());
    ThemeData theme = Theme.of(context);

    // List of sidebar items
    final sidebarItems = [
      {
        "icon": Icons.color_lens_rounded,
        "label": "Color Palette",
        "pageIndex": 0,
      },
      {
        "icon": Icons.widgets_rounded,
        "label": "Widget",
        "pageIndex": 1,
      },
    ];

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: theme.colorScheme.primary,
              child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: sidebarItems.map((item) {
                      final isSelected =
                          sideBarController.index.value == item["pageIndex"];
                      return GestureDetector(
                        onTap: () => sideBarController.index.value =
                            item["pageIndex"] as int,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected
                                ? Colors.white.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item["icon"] as IconData,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item["label"] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ),
          ),
          Expanded(
            flex: 4,
            child: Obx(
                () => sideBarController.pages[sideBarController.index.value]),
          ),
        ],
      ),
    );
  }
}
