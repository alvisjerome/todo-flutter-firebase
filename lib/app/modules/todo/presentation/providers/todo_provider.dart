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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dateTime = DateTime.now();

  set dateTime(DateTime value) {
    _dateTime = value;
    notifyListeners();
  }

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;

  String get title {
    final value = _titleController.text.trim();

    if (value.isNotEmpty) {
      return value;
    }
    return "";
  }

  String get description {
    final value = _descriptionController.text.trim();

    if (value.isNotEmpty) {
      return value;
    }
    return "";
  }

  String getDateTime({required TodoUseCase useCase, Todo? todo}) {
    return Conversion.formatDate(_dateTime ?? todo?.dateTime);
  }

  void setInitialValuesOnEdit(Todo? todo) {
    _titleController.text = todo?.title ?? "";
    _descriptionController.text = todo?.description ?? "";
  }

  Future<void> handleAddOrEdit(
      {TodoUseCase? useCase,
      String? id,
      required RequestHandlers handlers}) async {
    try {
      final todo = Todo(
        id: id,
        title: title,
        description: description,
        dateTime: _dateTime,
      );
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
