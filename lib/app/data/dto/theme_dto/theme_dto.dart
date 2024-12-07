class ThemeDto {
  final ThemeGroup? lightTheme;
  final ThemeGroup? darkTheme;

  ThemeDto({
    this.lightTheme,
    this.darkTheme,
  });

  // CopyWith method to create a new instance with updated values
  ThemeDto copyWith({
    ThemeGroup? lightTheme,
    ThemeGroup? darkTheme,
  }) {
    return ThemeDto(
      lightTheme: lightTheme ?? this.lightTheme,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }

  // Manually parse JSON to create a ThemeDto instance
  factory ThemeDto.fromJson(Map<String, dynamic> json) {
    return ThemeDto(
      lightTheme: json['lightTheme'] != null
          ? ThemeGroup.fromJson(json['lightTheme'], prefix: 'light_')
          : null,
      darkTheme: json['darkTheme'] != null
          ? ThemeGroup.fromJson(json['darkTheme'], prefix: 'dark_')
          : null,
    );
  }

  // Convert ThemeDto instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'lightTheme': lightTheme?.toJson(),
      'darkTheme': darkTheme?.toJson(),
    };
  }
}

class ThemeGroup {
  // Light theme properties
  final String? light_primary;
  final String? light_secondary;
  final String? light_surface;
  final String? light_background;
  final String? light_error;
  final String? light_onPrimary;
  final String? light_onSecondary;
  final String? light_onSurface;
  final String? light_onBackground;
  final String? light_onError;

  // Dark theme properties
  final String? dark_primary;
  final String? dark_secondary;
  final String? dark_surface;
  final String? dark_background;
  final String? dark_error;
  final String? dark_onPrimary;
  final String? dark_onSecondary;
  final String? dark_onSurface;
  final String? dark_onBackground;
  final String? dark_onError;

  ThemeGroup({
    // Light theme properties
    this.light_primary,
    this.light_secondary,
    this.light_surface,
    this.light_background,
    this.light_error,
    this.light_onPrimary,
    this.light_onSecondary,
    this.light_onSurface,
    this.light_onBackground,
    this.light_onError,

    // Dark theme properties
    this.dark_primary,
    this.dark_secondary,
    this.dark_surface,
    this.dark_background,
    this.dark_error,
    this.dark_onPrimary,
    this.dark_onSecondary,
    this.dark_onSurface,
    this.dark_onBackground,
    this.dark_onError,
  });

  // CopyWith method to create a new instance with updated values
  ThemeGroup copyWith({
    // Light theme properties
    String? light_primary,
    String? light_secondary,
    String? light_surface,
    String? light_background,
    String? light_error,
    String? light_onPrimary,
    String? light_onSecondary,
    String? light_onSurface,
    String? light_onBackground,
    String? light_onError,

    // Dark theme properties
    String? dark_primary,
    String? dark_secondary,
    String? dark_surface,
    String? dark_background,
    String? dark_error,
    String? dark_onPrimary,
    String? dark_onSecondary,
    String? dark_onSurface,
    String? dark_onBackground,
    String? dark_onError,
  }) {
    return ThemeGroup(
      // Light theme properties
      light_primary: light_primary ?? this.light_primary,
      light_secondary: light_secondary ?? this.light_secondary,
      light_surface: light_surface ?? this.light_surface,
      light_background: light_background ?? this.light_background,
      light_error: light_error ?? this.light_error,
      light_onPrimary: light_onPrimary ?? this.light_onPrimary,
      light_onSecondary: light_onSecondary ?? this.light_onSecondary,
      light_onSurface: light_onSurface ?? this.light_onSurface,
      light_onBackground: light_onBackground ?? this.light_onBackground,
      light_onError: light_onError ?? this.light_onError,

      // Dark theme properties
      dark_primary: dark_primary ?? this.dark_primary,
      dark_secondary: dark_secondary ?? this.dark_secondary,
      dark_surface: dark_surface ?? this.dark_surface,
      dark_background: dark_background ?? this.dark_background,
      dark_error: dark_error ?? this.dark_error,
      dark_onPrimary: dark_onPrimary ?? this.dark_onPrimary,
      dark_onSecondary: dark_onSecondary ?? this.dark_onSecondary,
      dark_onSurface: dark_onSurface ?? this.dark_onSurface,
      dark_onBackground: dark_onBackground ?? this.dark_onBackground,
      dark_onError: dark_onError ?? this.dark_onError,
    );
  }

  // Manually parse JSON to create a ThemeGroup instance with the prefix
  factory ThemeGroup.fromJson(Map<String, dynamic> json,
      {required String prefix}) {
    return ThemeGroup(
      // Light theme properties
      light_primary: json['${prefix}primary'] as String?,
      light_secondary: json['${prefix}secondary'] as String?,
      light_surface: json['${prefix}surface'] as String?,
      light_background: json['${prefix}background'] as String?,
      light_error: json['${prefix}error'] as String?,
      light_onPrimary: json['${prefix}onPrimary'] as String?,
      light_onSecondary: json['${prefix}onSecondary'] as String?,
      light_onSurface: json['${prefix}onSurface'] as String?,
      light_onBackground: json['${prefix}onBackground'] as String?,
      light_onError: json['${prefix}onError'] as String?,

      // Dark theme properties
      dark_primary: json['${prefix}primary'] as String?,
      dark_secondary: json['${prefix}secondary'] as String?,
      dark_surface: json['${prefix}surface'] as String?,
      dark_background: json['${prefix}background'] as String?,
      dark_error: json['${prefix}error'] as String?,
      dark_onPrimary: json['${prefix}onPrimary'] as String?,
      dark_onSecondary: json['${prefix}onSecondary'] as String?,
      dark_onSurface: json['${prefix}onSurface'] as String?,
      dark_onBackground: json['${prefix}onBackground'] as String?,
      dark_onError: json['${prefix}onError'] as String?,
    );
  }

  // Convert ThemeGroup instance to JSON
  Map<String, dynamic> toJson() {
    return {
      // Light theme properties
      'light_primary': light_primary,
      'light_secondary': light_secondary,
      'light_surface': light_surface,
      'light_background': light_background,
      'light_error': light_error,
      'light_onPrimary': light_onPrimary,
      'light_onSecondary': light_onSecondary,
      'light_onSurface': light_onSurface,
      'light_onBackground': light_onBackground,
      'light_onError': light_onError,

      // Dark theme properties
      'dark_primary': dark_primary,
      'dark_secondary': dark_secondary,
      'dark_surface': dark_surface,
      'dark_background': dark_background,
      'dark_error': dark_error,
      'dark_onPrimary': dark_onPrimary,
      'dark_onSecondary': dark_onSecondary,
      'dark_onSurface': dark_onSurface,
      'dark_onBackground': dark_onBackground,
      'dark_onError': dark_onError,
    };
  }
}
