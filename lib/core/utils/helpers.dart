import 'package:app/core/common/app_keys.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/component_functions.dart';
import '../../app/widgets/custom_text.dart';
import '../theme/app_theme.dart';

final class Helpers {
  static void onErrorSnackbar(String? message, BuildContext context) {
    ComponentFunctions.handleSnackBar(
        context: AppKeys.navigatorKey.currentContext ?? context,
        snakbar: SnackBar(
          backgroundColor: AppTheme.deepRed,
          content: CustomText(
            value: message ?? "Something went wrong",
            color: AppTheme.white,
          ),
        ));
  }

  static void onLoadingSnackbar(BuildContext context) {
    ComponentFunctions.handleSnackBar(
        context: AppKeys.navigatorKey.currentContext ?? context,
        snakbar: SnackBar(
            backgroundColor: AppTheme.tealGreen,
            content: Row(
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
            )));
  }

  static void onSuccessSnackbar(BuildContext context, [String? message]) {
    ComponentFunctions.handleSnackBar(
        context: AppKeys.navigatorKey.currentContext ?? context,
        snakbar: SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: AppTheme.tealGreen,
            content: CustomText(
              value: message ?? "Success!",
              color: AppTheme.white,
            )));
  }
}
