import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/modules/authentication/presentation/pages/authentication_page.dart';
import '../../app/modules/authentication/presentation/pages/profile_page.dart';
import '../../app/modules/authentication/presentation/providers/authentication_providers.dart';
import '../../app/modules/todo/presentation/pages/todo_edit_page.dart';
import '../../app/modules/todo/presentation/pages/todo_page.dart';
import '../../app/widgets/error_page.dart';
import '../utils/typedefs.dart';
import 'route_paths.dart';
import 'router_refresh_listenable.dart';

final rootNavigatorKeyProvider =
    Provider<GlobalKey<NavigatorState>>((ref) => GlobalKey<NavigatorState>());

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final rootNavigatorKey = ref.watch(rootNavigatorKeyProvider);

  return GoRouter(
    initialLocation: RoutePaths.auth,
    navigatorKey: rootNavigatorKey,
    refreshListenable: RouterRefreshListenable(authRepository.authStateChanges),
    redirect: (context, state) {
      final authenticated = authRepository.currentUser != null;
      if (authenticated) {
        if (state.location.startsWith(RoutePaths.auth)) {
          return RoutePaths.todo;
        }
      } else {
        if (state.location.startsWith(RoutePaths.todo)) {
          return RoutePaths.auth;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.auth,
        name: RouteNames.auth.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const AuthenticationPage(),
          );
        },
      ),
      GoRoute(
          path: RoutePaths.todo,
          name: RouteNames.todo.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const TodoPage(),
            );
          },
          routes: [
            GoRoute(
              path: RoutePaths.editTodo,
              name: RouteNames.editTodo.name,
              pageBuilder: (context, state) {
                final routeProps = state.extra as TodoRouteProps;
                return MaterialPage(
                    key: state.pageKey,
                    child: TodoEditPage(routeProps: routeProps));
              },
            ),
            GoRoute(
              path: RoutePaths.profile,
              name: RouteNames.profile.name,
              pageBuilder: (context, state) {
                return MaterialPage(
                    key: state.pageKey, child: const ProfilePage());
              },
            ),
          ])
    ],
    errorBuilder: (context, state) {
      return ErrorPage(
        message: state.error?.message,
      );
    },
  );
});
