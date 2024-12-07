import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('ERROR'),
      content: Text(message),
    );
  }
}
