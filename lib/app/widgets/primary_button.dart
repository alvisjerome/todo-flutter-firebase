import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  final Color? color, labelColor;
  final String labelText;
  final VoidCallback onPressed;
  final double? height, width;

  const PrimaryButton({
    super.key,
    this.color,
    this.labelColor,
    this.height,
    this.width,
    required this.labelText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: color ?? AppTheme.black,
          fixedSize: Size(width ?? double.maxFinite, height ?? 48)),
      onPressed: onPressed,
      child: CustomText(
        value: labelText,
        color: labelColor ?? AppTheme.white,
      ),
    );
  }
}