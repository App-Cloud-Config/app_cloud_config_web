import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StringHelper on String? {
  bool get isValidUrl {
    return Uri.parse(this!).isAbsolute;
  }

  bool get isValidUrlAndNotNull {
    return isValidUrl && this != null && this!.isNotEmpty;
  }

  Future<bool?> showToast(ToastType toastType) {
    return Fluttertoast.showToast(
      msg: "$this",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: _getColorByToastType(toastType),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Adding capitalize method
  String? capitalize() {
    if (this == null || this!.isEmpty) return this;
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }

  _getColorByToastType(ToastType toastType) {
    switch (toastType) {
      case ToastType.error:
        return Colors.red;
      case ToastType.success:
        return Colors.green;
      case ToastType.log:
        return Colors.grey.shade400;
      default:
    }
  }
}

enum ToastType {
  error,
  success,
  log,
}
