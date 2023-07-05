import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../datasource/repositories/authentication_repository.dart';

class AuthenticationProvider with ChangeNotifier {
  final authenticationRepository = sl<AuthenticationRepository>();

  User? _userValue;
  User? get user => _userValue;

  Future<void> handleGoogleSignIn() async {
    final userCredential =
        await authenticationRepository.authenticateWithGoogle();
    _userValue = userCredential.user;
  }

  Future<void> handleSignOut() async {
    await authenticationRepository.signOut();
  }
}
