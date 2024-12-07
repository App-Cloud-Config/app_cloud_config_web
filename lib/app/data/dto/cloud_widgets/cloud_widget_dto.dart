// widget_dto.dart
import 'package:app_cloud_config_web/app/core/enums/cloud_widgets.dart';

class CloudWidgetDto {
  final String widgetId;
  final CloudWidgets widgetType;
  final Map<String, dynamic> properties;

  CloudWidgetDto({
    required this.widgetId,
    required this.widgetType,
    required this.properties,
  });

  Map<String, dynamic> toJson() {
    return {
      widgetId: {
        'widgetType': widgetType.name,
        ...properties,
      },
    };
  }
}
