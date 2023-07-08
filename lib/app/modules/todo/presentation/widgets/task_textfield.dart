import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;

  const TaskTextField(
      {super.key,
      this.maxLines,
      required this.controller,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12));

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.body,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.body.copyWith(),
        focusedBorder: outlineBorder,
        enabledBorder: outlineBorder,
        filled: true,
        fillColor: AppTheme.lightPink,
        border: InputBorder.none,
      ),
    );
  }
}
