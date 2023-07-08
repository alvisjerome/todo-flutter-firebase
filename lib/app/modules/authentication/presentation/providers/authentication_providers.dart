import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../datasource/models/main_user.dart';
import '../../datasource/repositories/authentication_repository.dart';

final googleSignInProvider = Provider((ref) => GoogleSignIn());
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) {
    return AuthenticationRepositoryImpl(
      googleSignIn: ref.read<GoogleSignIn>(googleSignInProvider),
      firebaseAuth: ref.read<FirebaseAuth>(firebaseAuthProvider),
    );
  },
);

final authNotifierProvider =
    AsyncNotifierProvider<AuthenticationNotifier, UserCredential?>(
        AuthenticationNotifier.new);

class AuthenticationNotifier extends AsyncNotifier<UserCredential?> {
  @override
  FutureOr<UserCredential?> build() {
    return null;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await ref.watch(authRepositoryProvider).authenticateWithGoogle();
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(authRepositoryProvider).signOut();
      return;
    });
  }
}

final userProvider = StateProvider((ref) {
  final authNotifier = ref.watch(authNotifierProvider);
  return MainUser.fromUser(authNotifier.value?.user);
});
