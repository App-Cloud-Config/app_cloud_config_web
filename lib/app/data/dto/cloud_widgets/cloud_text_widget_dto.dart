class CloudTextWidgetDto {
  final String? text;
  final String? fontSize;
  final String? fontWeight;
  final String? fontStyle;
  final String? textAlign;
  final String? overflow;
  final String? maxLines;

  CloudTextWidgetDto({
    this.text,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  // From JSON to DTO
  factory CloudTextWidgetDto.fromJson(Map<String, dynamic> json) {
    return CloudTextWidgetDto(
      text: json['text'],
      fontSize: json['fontSize'],
      fontWeight: json['fontWeight'],
      fontStyle: json['fontStyle'],
      textAlign: json['textAlign'],
      overflow: json['overflow'],
      maxLines: json['maxLines'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'fontStyle': fontStyle,
      'textAlign': textAlign,
      'overflow': overflow,
      'maxLines': maxLines,
    };
  }

  // CopyWith method for updating properties
  CloudTextWidgetDto copyWith({
    String? text,
    String? fontSize,
    String? fontWeight,
    String? fontStyle,
    String? textAlign,
    String? overflow,
    String? maxLines,
  }) {
    return CloudTextWidgetDto(
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      textAlign: textAlign ?? this.textAlign,
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}
