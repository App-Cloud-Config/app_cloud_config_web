class WidgetModel {
  final String widgetType;
  final String widgetId;
  final String? text;
  final String? width;
  final String? height;
  final String? fontSize;
  final String? color;
  final String? fontWeight;
  final String? fontStyle;
  final String? textAlign;
  final String? maxLines;

  WidgetModel({
    required this.widgetType,
    required this.widgetId,
    this.text,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontStyle,
    this.textAlign,
    this.maxLines,
  });

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    return WidgetModel(
      widgetType: json['widgetType'],
      widgetId: json['widgetId'],
      text: json['text'],
      width: json['width'],
      height: json['height'],
      fontSize: json['fontSize'],
      color: json['color'],
      fontWeight: json['fontWeight'],
      fontStyle: json['fontStyle'],
      textAlign: json['textAlign'],
      maxLines: json['maxLines'],
    );
  }
}
