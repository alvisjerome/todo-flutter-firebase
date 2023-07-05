import '../../../../widgets/custom_text.dart';
import '../../../../../core/theme/app_theme.dart';

import 'package:flutter/material.dart';

class DeleteTaskSnackbar extends SnackBar {
  const DeleteTaskSnackbar({super.key})
      : super(
          backgroundColor: AppTheme.tealGreen,
          duration: const Duration(seconds: 1),
          content: const CustomText(
            value: "Task has successfully deleted!",
            color: AppTheme.white,
          ),
        );
}
