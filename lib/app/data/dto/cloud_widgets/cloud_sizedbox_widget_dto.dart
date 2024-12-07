class CloudSizedBoxWidgetDto {
  final String? height;
  final String? width;

  CloudSizedBoxWidgetDto({
    this.height,
    this.width,
  });

  // From JSON to DTO
  factory CloudSizedBoxWidgetDto.fromJson(Map<String, dynamic> json) {
    return CloudSizedBoxWidgetDto(
      height: json['height'],
      width: json['width'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'width': width,
    };
  }

  // CopyWith method for updating properties
  CloudSizedBoxWidgetDto copyWith({
    String? height,
    String? width,
  }) {
    return CloudSizedBoxWidgetDto(
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }
}
