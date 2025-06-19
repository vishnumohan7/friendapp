import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height = 48.0,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 8.0,
    this.padding,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isOutlined
          ? Colors.transparent
          : backgroundColor ?? colorScheme.primary,
      foregroundColor:
          isOutlined ? colorScheme.primary : foregroundColor ?? Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: isOutlined
            ? BorderSide(color: colorScheme.primary, width: 1.5)
            : BorderSide.none,
      ),
      padding: padding,
      minimumSize: Size(width ?? double.infinity, height ?? 48.0),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: child,
    );
  }
}
