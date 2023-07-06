import 'custom_text.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomText(
          value: message ?? "Something went wrong",
          align: TextAlign.center,
        ),
      ),
    );
  }
}
