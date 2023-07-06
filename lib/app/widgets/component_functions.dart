import 'package:flutter/material.dart';

final class ComponentFunctions {
  static void handleSnackBar(
      {required BuildContext context, required SnackBar snakbar}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snakbar);
  }
}
