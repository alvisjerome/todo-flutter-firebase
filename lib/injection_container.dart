import 'package:get_it/get_it.dart';

import 'app/modules/authentication/datasource/repositories/authentication_repository.dart';
import 'app/modules/todo/datasource/repositories/todo_repository.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl());
}
