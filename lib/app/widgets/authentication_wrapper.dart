import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modules/authentication/presentation/pages/authentication_page.dart';
import '../modules/todo/presentation/pages/todo_page.dart';
import 'error_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  final Stream<User?> authStateChanges;
  const AuthenticationWrapper({super.key, required this.authStateChanges});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const ErrorPage();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return const TodoPage();
            } else {
              return const AuthenticationPage();
            }
          }

          return const Material();
        });
  }
}
