import 'package:flutter/material.dart';

extension BuildContextExtension<T> on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
  TextTheme get textStyle => Theme.of(this).textTheme;
}
