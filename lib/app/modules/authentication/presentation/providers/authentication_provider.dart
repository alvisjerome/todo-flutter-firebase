import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/conversion.dart';
import '../../../../../core/utils/request_handlers.dart';
import '../../../../../injection_container.dart';
import '../../datasource/models/main_user.dart';
import '../../datasource/repositories/authentication_repository.dart';

class AuthenticationProvider with ChangeNotifier {
  final authenticationRepository = sl<AuthenticationRepository>();

  final firebaseAuth = sl<FirebaseAuth>();

  UserCredential? userCredential;
  User? get user => userCredential?.user ?? firebaseAuth.currentUser;

  MainUser get mainUser => MainUser(
        name: user?.displayName ?? "",
        email: user?.email ?? "",
        photo: user?.photoURL ?? "",
        created: Conversion.formatDate(user?.metadata.creationTime),
      );

  void handleGoogleSignIn({required RequestHandlers requestHandlers}) async {
    try {
      requestHandlers.onLoading!();
      userCredential = await authenticationRepository.authenticateWithGoogle();
      requestHandlers.onSuccess!();
    } on FirebaseException catch (e) {
      requestHandlers.onError!(e.message.toString());
    } catch (e) {
      requestHandlers.onError!();
    }
  }

  void handleSignOut({required RequestHandlers requestHandlers}) async {
    requestHandlers.onLoading!();
    try {
      await authenticationRepository.signOut();
      requestHandlers.onSuccess!();
    } on FirebaseException catch (e) {
      requestHandlers.onError!(e.message.toString());
    } catch (e) {
      requestHandlers.onError!();
    }
  }
}
