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

class TodoNotifier extends AsyncNotifier<TodoUseCase> {
  @override
  FutureOr<TodoUseCase> build() {
    return TodoUseCase.none;
  }

  Future<void> performTodoAcions(
      {required Todo todo, required TodoUseCase useCase}) async {
    final repository = ref.read(todoRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      if (useCase == TodoUseCase.add) {
        repository.addTodo(todo);
      } else if (useCase == TodoUseCase.edit) {
        repository.updateTodo(todo);
      } else if (useCase == TodoUseCase.delete) {
        repository.deleteTodo(todo.id ?? "");
      }

      return useCase;
    });
  }
}

final todoNotifierProvider =
    AsyncNotifierProvider<TodoNotifier, TodoUseCase>(TodoNotifier.new);
