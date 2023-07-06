import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;

  const TaskTextField(
      {super.key,
      required this.controller,
      this.maxLines,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.body,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.body.copyWith(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: AppTheme.lightPink,
        border: InputBorder.none,
      ),
    );
  }
}
