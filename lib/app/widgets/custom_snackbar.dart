import 'package:flutter/material.dart';

import '../../core/enums/snackbar_types.dart';
import '../../core/theme/app_theme.dart';
import 'custom_text.dart';

class CustomSnackbar extends SnackBar {
  final SnackbarType? type;
  final String? message;
  CustomSnackbar({super.key, this.type = SnackbarType.none, this.message})
      : super(
          duration: const Duration(milliseconds: 500),
          backgroundColor: type == SnackbarType.error
              ? AppTheme.deepRed
              : AppTheme.tealGreen,
          content: type == SnackbarType.loading
              ? Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      margin: const EdgeInsets.only(right: 15.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: AppTheme.white,
                        color: AppTheme.amber,
                      ),
                    ),
                    const CustomText(
                      value: "Please wait..",
                      color: AppTheme.white,
                    )
                  ],
                )
              : CustomText(
                  value: message ?? "",
                  color: AppTheme.white,
                ),
        );
}
