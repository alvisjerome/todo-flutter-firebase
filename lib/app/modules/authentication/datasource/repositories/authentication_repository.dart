import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthenticationRepository {
  Stream<User?> get authStateChanges;
  Future<UserCredential> authenticateWithGoogle();
  Future<void> signOut();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  AuthenticationRepositoryImpl(
      {required this.googleSignIn, required this.firebaseAuth});

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> authenticateWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final user = await firebaseAuth.signInWithCredential(credential);
    return user;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
