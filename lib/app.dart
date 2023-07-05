import 'package:flutter/material.dart';

import 'core/routes/app_paths.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

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
