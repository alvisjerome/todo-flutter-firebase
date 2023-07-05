import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app/modules/authentication/datasource/repositories/authentication_repository.dart';
import 'app/modules/todo/datasource/repositories/todo_repository.dart';

final sl = GetIt.instance; //Service Locator

Future<void> setup() async {
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      googleSignIn: sl(),
      firebaseAuth: sl(),
    ),
  );
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      firestore: sl(),
    ),
  );
}

void cleanup() {
  sl.reset();
}
