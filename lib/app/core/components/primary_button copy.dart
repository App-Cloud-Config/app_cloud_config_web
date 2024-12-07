
import 'package:app_cloud_config_web/app/core/extension/buildcontext_extension.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.futureAction,
    this.label,
    this.labelText,
    this.borderColor,
    this.backgroundColor,
    this.icon,
    this.onComplete,
    this.isPrimary = true,
  }) : assert(
          onPressed == null || futureAction == null,
          'Cannot provide both onPressed and futureAction.',
        );

  final VoidCallback? onPressed;
  final Future<void> Function()? futureAction;
  final Function? onComplete;
  final Text? label;
  final String? labelText;
  final bool isPrimary;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget? icon;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isLoading = false;

  void _handlePress() async {
    if (widget.futureAction != null) {
      setState(() {
        _isLoading = true;
      });
      try {
        await widget.futureAction?.call();
      } finally {
        widget.onComplete?.call();
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _handlePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isPrimary
            ? context.colorScheme.primary
            : widget.backgroundColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: BorderSide(
            color: widget.borderColor ?? context.colorScheme.primary,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
      icon: widget.icon,
      label: _isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: context.colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            )
          : (widget.label ??
              Text(
                widget.labelText ?? '',
                style: context.textStyle.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onPrimary,
                ),
              )),
    );
  }
}
