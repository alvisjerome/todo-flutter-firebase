import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/utils/typedefs.dart';
import '../../../../widgets/custom_text.dart';
import '../../datasource/models/todo.dart';
import '../providers/todo_providers.dart';

class TaskMenu extends ConsumerWidget {
  final Todo? todo;
  const TaskMenu({super.key, required this.todo});

  void onMenuSelected(BuildContext context, String value, WidgetRef ref) {
    final todosProvider = ref.read(todoNotifierProvider.notifier);
    if (value == TodoUseCase.edit.name) {
      final TodoRouteProps routeProps = (useCase: TodoUseCase.edit, todo: todo);
      context.goNamed(RouteNames.editTodo.name, extra: routeProps);
    } else if (value == TodoUseCase.delete.name) {
      if (todo != null) {
        todosProvider.performTodoActions(
            todo: todo!, useCase: TodoUseCase.delete);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      elevation: 0.5,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: TodoUseCase.edit.name,
          child: const CustomText(value: "Edit"),
        ),
        PopupMenuItem<String>(
          value: TodoUseCase.delete.name,
          child: const CustomText(value: 'Delete'),
        ),
      ],
      onSelected: (String value) => onMenuSelected(context, value, ref),
      icon: const Icon(Icons.more_vert),
    );
  }
}
