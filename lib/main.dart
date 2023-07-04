import 'package:app/core/routes/app_paths.dart';
import 'package:app/core/routes/app_routes.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STAGE Todo',
      theme: AppTheme.appTheme(context),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppPaths.auth,
    );
  }
}
