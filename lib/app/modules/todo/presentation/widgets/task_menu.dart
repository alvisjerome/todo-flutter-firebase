import 'package:flutter/material.dart';

import '../../../../../core/enums/todo_menu_enum.dart';
import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/routes/app_paths.dart';
import '../../../../widgets/component_functions.dart';
import '../../../../widgets/custom_text.dart';
import 'delete_task_snackbar.dart';

class TaskMenu extends StatelessWidget {
  const TaskMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
          Navigator.pushNamed(context, AppPaths.editTodo,
              arguments: TodoUseCase.editTodo);
        } else if (value == TodoMenuEnum.delete.name) {
          ComponentFunctions.hanleSnackBar(
              context: context, snakbar: const DeleteTaskSnackbar());
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
