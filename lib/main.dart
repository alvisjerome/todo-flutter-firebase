import 'core/routes/app_paths.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/common/app_providers.dart';

void main() {
  runApp(MultiProvider(
    providers: AppProviders.providers,
    child: const MyApp(),
  ));
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
