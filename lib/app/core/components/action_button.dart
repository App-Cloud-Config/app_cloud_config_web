import 'package:app_cloud_config_web/app/core/extension/buildcontext_extension.dart';
import 'package:app_cloud_config_web/app/core/extension/widget_extension.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  const ActionButton({
    super.key,
    this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: context.colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add_circle_rounded,
              color: context.colorScheme.primary,
            ),
            5.width,
            Text(
              label,
              style: context.textTheme.labelMedium!.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
