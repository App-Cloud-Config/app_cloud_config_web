import 'package:app_cloud_config_web/app/modules/cloud_widgets/controllers/list_widget_controller.dart';
import 'package:app_cloud_config_web/app/modules/cloud_widgets/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WidgetListView extends GetView<WidgetListController> {
  const WidgetListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      autoRemove: false,
      init: WidgetListController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                controller.obx(
                  onEmpty: const Center(
                      child: Text(
                    'No widgets available',
                    style: TextStyle(color: Colors.black),
                  )),
                  onError: (e) => Center(
                    child: Text(e.toString()),
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  (state) => Expanded(
                    child: ListView.builder(
                      itemCount: controller.widgets.length,
                      itemBuilder: (context, index) {
                        final widget = controller.widgets[index];

                        // Render each widget
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            tileColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            title: Text(
                              widget.widgetType,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display widgetId (e.g., sizedbox_JH15j)
                                SelectableText('Widget ID: ${widget.widgetId}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),

                                // Conditionally display properties only if they exist
                                if (widget.text != null && widget.text != '')
                                  Text('Text: ${widget.text}'),
                                if (widget.width != null && widget.width != '')
                                  Text('Width: ${widget.width}'),
                                if (widget.height != null &&
                                    widget.height != '')
                                  Text('Height: ${widget.height}'),
                                if (widget.fontSize != null &&
                                    widget.fontSize != '')
                                  Text('Font Size: ${widget.fontSize}'),
                                if (widget.color != null && widget.color != '')
                                  Text('Color: ${widget.color}'),
                                if (widget.fontWeight != null &&
                                    widget.fontWeight != '')
                                  Text('Font Weight: ${widget.fontWeight}'),
                                if (widget.fontStyle != null &&
                                    widget.fontStyle != '')
                                  Text('Font Style: ${widget.fontStyle}'),
                                if (widget.textAlign != null &&
                                    widget.textAlign != '')
                                  Text('Text Align: ${widget.textAlign}'),
                                if (widget.maxLines != null &&
                                    widget.maxLines != '')
                                  Text('Max Lines: ${widget.maxLines}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy, color: Colors.grey),
                              onPressed: () {
                                // Copy widget ID to clipboard
                                Clipboard.setData(
                                    ClipboardData(text: widget.widgetId));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Widget ID copied to clipboard')),
                                );
                              },
                            ),
                            onTap: () {
                              // Pass widget properties and the widget type to the dialog
                              showDialog(
                                context: context,
                                builder: (context) => WidgetSelectionDialog(
                                  widgetId: widget.widgetId,
                                  initialWidgetType: widget.widgetType,
                                  initialText: widget.text,
                                  initialFontSize: widget.fontSize,
                                  initialWidth: widget.width,
                                  initialHeight: widget.height,
                                  initialColor: widget.color,
                                  initialFontWeight: widget.fontWeight,
                                  initialFontStyle: widget.fontStyle,
                                  initialTextAlign: widget.textAlign,
                                  initialMaxLines: widget.maxLines,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
