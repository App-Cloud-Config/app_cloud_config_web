import 'package:app_cloud_config_web/app/core/extension/buildcontext_extension.dart';
import 'package:app_cloud_config_web/app/core/extension/widget_extension.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryDropDownButton<T> extends StatelessWidget {
  final List<T> items;
  final bool enabled;
  final T selectedValue;
  final List<Widget>? prefix;
  final void Function(T?)? onChanged;
  const PrimaryDropDownButton({
    super.key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<T>(
        borderRadius: BorderRadius.circular(15),
        underline: const SizedBox.shrink(),
        focusColor: context.colorScheme.onSurface.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(
            // vertical: 2,
            ),
        value: selectedValue,
        icon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.colorScheme.onSurface,
          ),
        ),
        items: items.map((e) {
          int index = items.indexOf(e);
          return DropdownMenuItem<T>(
            value: e,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                // vertical: 15,
              ),
              child: Row(
                children: [
                  if (prefix != null && prefix!.isNotEmpty) prefix![index],
                  if (prefix != null && prefix!.isNotEmpty) 10.width,
                  Text(
                    e is Enum ? e.name.capitalize! : '$e',
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(
                        enabled ? 0.9 : 0.5,
                      ),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
