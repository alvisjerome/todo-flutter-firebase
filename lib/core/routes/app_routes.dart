import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/modules/authentication/presentation/pages/authentication_page.dart';
import '../../app/modules/authentication/presentation/pages/profile_page.dart';
import '../../app/modules/todo/presentation/pages/todo_edit_page.dart';
import '../../app/modules/todo/presentation/pages/todo_page.dart';
import '../../app/widgets/error_page.dart';
import '../enums/todo_usecase.dart';
import 'app_paths.dart';

final class AppRoutes {
  static Route<MaterialPageRoute> onGenerateRoute(RouteSettings? settings) {
    switch (settings?.name) {
      case AppPaths.auth:
        return MaterialPageRoute(builder: (_) => const AuthenticationPage());
      case AppPaths.todo:
        return MaterialPageRoute(builder: (_) => const TodoPage());
      case AppPaths.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppPaths.editTodo:
        return MaterialPageRoute(
            builder: (_) =>
                TodoEditPage(useCase: settings?.arguments as TodoUseCase?));
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }

  static String getInitialRoute(User? user) {
    return (user == null) ? AppPaths.auth : AppPaths.todo;
  }
}
