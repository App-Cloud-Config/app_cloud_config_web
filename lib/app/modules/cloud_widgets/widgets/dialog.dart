import 'package:app_cloud_config_web/app/core/enums/cloud_widgets.dart';
import 'package:app_cloud_config_web/app/modules/cloud_widgets/controllers/cloud_widgets_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetSelectionDialog extends StatelessWidget {
  final String? initialWidgetType;
  final String? widgetId;
  final String? initialText;
  final String? initialFontSize;
  final String? initialWidth;
  final String? initialHeight;
  final String? initialColor;
  final String? initialFontWeight;
  final String? initialFontStyle;
  final String? initialTextAlign;
  final String? initialMaxLines;

  const WidgetSelectionDialog({
    super.key,
    this.initialWidgetType,
    this.widgetId,
    this.initialText,
    this.initialFontSize,
    this.initialWidth,
    this.initialHeight,
    this.initialColor,
    this.initialFontWeight,
    this.initialFontStyle,
    this.initialTextAlign,
    this.initialMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    final CloudWidgetController controller = Get.put(CloudWidgetController());
    if (initialWidgetType != null) {
      // Set initial widget type and properties
      controller.selectedWidgetType.value = initialWidgetType!;
    }
    if (widgetId != null) {
      // Set initial widget type and properties
      controller.editWidgetId.value = widgetId!;
    }

    // Set initial values based on widget type
    if (initialWidgetType == CloudWidgets.Text.name) {
      controller.updateTextWidgetProperties(
        text: initialText,
        fontSize: initialFontSize,
        fontWeight: initialFontWeight,
        fontStyle: initialFontStyle,
        textAlign: initialTextAlign,
        maxLines: initialMaxLines,
      );
    } else if (initialWidgetType == CloudWidgets.SizedBox.name) {
      controller.updateSizedBoxWidgetProperties(
        width: initialWidth,
        height: initialHeight,
      );
    }

    return AlertDialog(
      title: const Text("Select Widget Properties"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<CloudWidgets>(
            value: CloudWidgets.values.firstWhere(
                (e) => e.name == controller.selectedWidgetType.value,
                orElse: () => CloudWidgets.Text),
            items: CloudWidgets.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
            onChanged: (value) {
              controller.selectedWidgetType.value = value!.name;
            },
          ),
          Obx(() {
            if (controller.selectedWidgetType.value == CloudWidgets.Text.name) {
              return Column(
                children: [
                  TextFormField(
                    initialValue: controller.textWidgetProperties.value?.text,
                    decoration: const InputDecoration(labelText: 'Text'),
                    onChanged: (value) {
                      controller.updateTextWidgetProperties(text: value);
                    },
                  ),
                  TextFormField(
                    initialValue:
                        controller.textWidgetProperties.value?.fontSize,
                    decoration: const InputDecoration(labelText: 'Font Size'),
                    onChanged: (value) {
                      controller.updateTextWidgetProperties(fontSize: value);
                    },
                  ),
                  // Add more fields as needed...
                ],
              );
            } else if (controller.selectedWidgetType.value ==
                CloudWidgets.SizedBox.name) {
              return Column(
                children: [
                  TextFormField(
                    initialValue:
                        controller.sizedBoxWidgetProperties.value?.width,
                    decoration: const InputDecoration(labelText: 'Width'),
                    onChanged: (value) {
                      controller.updateSizedBoxWidgetProperties(width: value);
                    },
                  ),
                  TextFormField(
                    initialValue:
                        controller.sizedBoxWidgetProperties.value?.height,
                    decoration: const InputDecoration(labelText: 'Height'),
                    onChanged: (value) {
                      controller.updateSizedBoxWidgetProperties(height: value);
                    },
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.saveWidget();
            Get.back();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
