import 'package:flutter/material.dart';

import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/utils/conversion.dart';
import '../../../../../injection_container.dart';
import '../../datasource/models/todo.dart';
import '../../datasource/repositories/todo_repository.dart';

class TodoProvider with ChangeNotifier {
  final _todoRepository = sl<TodoRepository>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dateTime;

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

  Future<void> modifyTodo({TodoUseCase? useCase, String? id}) async {
    final todo = Todo(
      id: id,
      title: title,
      description: description,
      dateTime: _dateTime,
    );
    if (useCase == TodoUseCase.addTodo) {
      await addTodo(todo);
    } else if (useCase == TodoUseCase.editTodo) {
      await updateTodo(todo);
    }
  }

  Future<String> addTodo(Todo todo) async {
    return await _todoRepository.addTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
  }

  Future<void> deleteTodo(String todoId) async {
    _todoRepository.deleteTodo(todoId);
  }

  Stream<List<Todo>> getAllTodos() {
    return _todoRepository.getTodos();
  }

  String formatDateTime(DateTime? dateTime) {
    return Conversion.formatDate(dateTime);
  }
}
