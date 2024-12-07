import 'package:app_cloud_config_web/app/data/dto/cloud_widgets/cloud_sizedbox_widget_dto.dart';
import 'package:app_cloud_config_web/app/data/dto/cloud_widgets/cloud_text_widget_dto.dart';

class GetCloudWidgetsDto {
  final Map<String, CloudSizedBoxWidgetDto>? sizedBoxWidgets;
  final Map<String, CloudTextWidgetDto>? textWidgets;

  GetCloudWidgetsDto({
    this.sizedBoxWidgets,
    this.textWidgets,
  });

  // From JSON to DTO
  factory GetCloudWidgetsDto.fromJson(Map<String, dynamic> json) {
    final widgetsJson = json['widgets'] as Map<String, dynamic>;

    final sizedBoxWidgets = <String, CloudSizedBoxWidgetDto>{};
    final textWidgets = <String, CloudTextWidgetDto>{};

    widgetsJson.forEach((key, value) {
      final widgetData = value as Map<String, dynamic>;
      final widgetType = widgetData['widgetType'];

      if (widgetType == 'SizedBox') {
        sizedBoxWidgets[key] = CloudSizedBoxWidgetDto.fromJson(widgetData);
      } else if (widgetType == 'Text') {
        textWidgets[key] = CloudTextWidgetDto.fromJson(widgetData);
      }
    });

    return GetCloudWidgetsDto(
      sizedBoxWidgets: sizedBoxWidgets.isNotEmpty ? sizedBoxWidgets : null,
      textWidgets: textWidgets.isNotEmpty ? textWidgets : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['widgets'] = {};

    if (sizedBoxWidgets != null) {
      sizedBoxWidgets!.forEach((key, widget) {
        data['widgets'][key] = widget.toJson()..['widgetType'] = 'SizedBox';
      });
    }

    if (textWidgets != null) {
      textWidgets!.forEach((key, widget) {
        data['widgets'][key] = widget.toJson()..['widgetType'] = 'Text';
      });
    }

    return data;
  }
}
