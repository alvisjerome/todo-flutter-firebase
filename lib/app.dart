import 'package:flutter/material.dart';

import 'app/modules/authentication/datasource/repositories/authentication_repository.dart';
import 'app/widgets/authentication_wrapper.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authStateChanges = sl<AuthenticationRepository>().authStateChanges;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STAGE Todo',
      theme: AppTheme.appTheme(context),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: AuthenticationWrapper(authStateChanges: authStateChanges),
    );
  }

  @override
  void dispose() {
    cleanup();
    super.dispose();
  }
}
