import 'package:flutter/material.dart';

final class ComponentFunctions {
  static void hanleSnackBar(
      {required BuildContext context, required SnackBar snakbar}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snakbar);
  }
}
