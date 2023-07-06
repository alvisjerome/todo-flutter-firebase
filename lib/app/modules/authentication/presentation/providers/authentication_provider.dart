import 'package:app/core/utils/conversion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../datasource/repositories/authentication_repository.dart';

class AuthenticationProvider with ChangeNotifier {
  final authenticationRepository = sl<AuthenticationRepository>();
  final firebaseAuth = sl<FirebaseAuth>();

  User? _userValue;
  User? get user => _userValue ?? firebaseAuth.currentUser;

  String get username {
    return user?.displayName ?? "";
  }

  String get email {
    return user?.email ?? "";
  }

  String get profilePicture {
    return user?.photoURL ?? "";
  }

  String get accountCreation {
    return Conversion.formatDate(user?.metadata.creationTime);
  }

  Future<void> handleGoogleSignIn() async {
    final userCredential =
        await authenticationRepository.authenticateWithGoogle();
    _userValue = userCredential.user;
  }

  Future<void> handleSignOut() async {
    await authenticationRepository.signOut();
  }
}
