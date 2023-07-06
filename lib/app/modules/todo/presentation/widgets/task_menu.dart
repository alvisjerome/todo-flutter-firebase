import 'package:app/app/modules/todo/presentation/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/enums/todo_menu_enum.dart';
import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/routes/app_paths.dart';
import '../../../../../core/utils/typedefs.dart';
import '../../../../widgets/component_functions.dart';
import '../../../../widgets/custom_text.dart';
import '../../datasource/models/todo.dart';
import 'delete_task_snackbar.dart';

class TaskMenu extends StatelessWidget {
  final Todo? todo;
  const TaskMenu({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    return PopupMenuButton<String>(
      elevation: 0.5,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: TodoMenuEnum.edit.name,
          child: const CustomText(value: "Edit"),
        ),
        PopupMenuItem<String>(
          value: TodoMenuEnum.delete.name,
          child: const CustomText(value: 'Delete'),
        ),
      ],
      onSelected: (String value) {
        if (value == TodoMenuEnum.edit.name) {
          final TodoRouteProps routeProps =
              (useCase: TodoUseCase.editTodo, todo: todo);
          Navigator.pushNamed(context, AppPaths.editTodo,
              arguments: routeProps);
          todoProvider.setInitialValuesOnEdit(todo);
        } else if (value == TodoMenuEnum.delete.name) {
          todoProvider.deleteTodo(todo?.id ?? "").then((value) =>
              ComponentFunctions.hanleSnackBar(
                  context: context, snakbar: const DeleteTaskSnackbar()));
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
