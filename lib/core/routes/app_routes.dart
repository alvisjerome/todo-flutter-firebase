import 'package:flutter/material.dart';

import '../../app/modules/authentication/presentation/pages/authentication_page.dart';
import '../../app/modules/home/presentation/pages/home_page.dart';
import '../../app/modules/profile/presentation/pages/profile_page.dart';
import '../../app/modules/todo/presentation/pages/todo_page.dart';
import 'app_paths.dart';

final class AppRoutes {
  static Route<MaterialPageRoute> onGenerateRoute(RouteSettings? settings) {
    switch (settings?.name) {
      case AppPaths.auth:
        return MaterialPageRoute(builder: (_) => const AuthenticationPage());
      case AppPaths.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppPaths.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppPaths.todo:
        return MaterialPageRoute(builder: (_) => const TodoPage());
      default:
        return MaterialPageRoute(builder: (_) => const _ErrorPage());
    }
  }
}

class _ErrorPage extends StatelessWidget {
  const _ErrorPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Something went wrong"),
      ),
    );
  }
}
