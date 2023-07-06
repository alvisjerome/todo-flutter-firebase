import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/utils/conversion.dart';
import '../../../../../core/utils/request_handlers.dart';
import '../../../../../injection_container.dart';
import '../../datasource/models/todo.dart';
import '../../datasource/repositories/todo_repository.dart';

class TodoProvider with ChangeNotifier {
  final _todoRepository = sl<TodoRepository>();

  Future<void> handleAddOrEdit(
      {required TodoUseCase? useCase,
      required Todo todo,
      required RequestHandlers handlers}) async {
    try {
      if (todo.title?.isNotEmpty ?? false) {
        handlers.onLoading!();
        if (useCase == TodoUseCase.addTodo) {
          await _todoRepository.addTodo(todo);
        } else if (useCase == TodoUseCase.editTodo) {
          await _todoRepository.updateTodo(todo);
        }
        handlers.onSuccess!();
      }
    } on FirebaseException catch (e) {
      handlers.onError!(e.message);
    } catch (e) {
      handlers.onError!();
    }
  }

  void handleDeleteTodo(
      {required String todoId, required RequestHandlers handlers}) async {
    try {
      handlers.onLoading!();
      await _todoRepository.deleteTodo(todoId);
      handlers.onSuccess!();
    } on FirebaseException catch (e) {
      handlers.onError!(e.message);
    } catch (e) {
      handlers.onError!();
    }
  }

  Stream<List<Todo>> getAllTodos() {
    return _todoRepository.getTodos();
  }

  String formatDateTime(DateTime? dateTime) {
    return Conversion.formatDate(dateTime);
  }
}
