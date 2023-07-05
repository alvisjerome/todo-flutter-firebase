import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'custom_text.dart';

class ErrorSnackbar extends SnackBar {
  final String? errorMessage;
  ErrorSnackbar({super.key, this.errorMessage})
      : super(
          backgroundColor: AppTheme.deepRed,
          duration: const Duration(seconds: 1),
          content: CustomText(
            value: errorMessage ?? "Something went wrong",
            color: AppTheme.white,
          ),
        );
}
