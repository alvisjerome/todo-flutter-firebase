import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/enums/todo_usecase.dart';
import '../../../authentication/presentation/providers/authentication_providers.dart';
import '../../datasource/models/todo.dart';
import '../../datasource/repositories/todo_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepositoryImpl(
      firestore: ref.read<FirebaseFirestore>(firestoreProvider),
      firebaseAuth: ref.read<FirebaseAuth>(firebaseAuthProvider));
});

final getTodosProvider =
    StreamProvider((ref) => ref.watch(todoRepositoryProvider).getTodos());

class TodoNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> performTodoAcions(
      {required Todo todo, required TodoUseCase useCase}) async {
    final repository = ref.read(todoRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => switch (useCase) {
          TodoUseCase.add => repository.addTodo(todo),
          TodoUseCase.edit => repository.updateTodo(todo),
          TodoUseCase.delete => repository.deleteTodo(todo.id ?? "")
        });
  }
}

final todoNotifierProvider = AsyncNotifierProvider(TodoNotifier.new);
