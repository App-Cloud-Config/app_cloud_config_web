import 'package:flutter/material.dart';

import '../extension/string_extension.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String description;
  final List<String>? confirmationAlert; // Optional list for checkbox items
  final VoidCallback? onCancel;
  final VoidCallback? onDone;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    this.confirmationAlert,
    this.onCancel,
    this.onDone,
  });

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            widget.title,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          if (widget.confirmationAlert != null) ...[
            const SizedBox(height: 16),
            ...widget.confirmationAlert!.map(
              (alertText) => CheckboxListTile.adaptive(
                title: Text(
                  alertText,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                value: isChecked,
                activeColor: colorScheme.primary,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel ?? () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.error,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: widget.confirmationAlert != null && !isChecked
              ? () {
                  'Please check the confirmation alert'
                      .showToast(ToastType.error);
                }
              : widget.onDone,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
          ),
          child: Text(
            'Confirm',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
