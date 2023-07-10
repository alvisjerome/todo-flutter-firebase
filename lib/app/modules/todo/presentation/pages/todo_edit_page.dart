import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/conversion.dart';
import '../../../../../core/utils/typedefs.dart';
import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../../datasource/models/todo.dart';
import '../providers/todo_providers.dart';
import '../widgets/task_textfield.dart';

class TodoEditPage extends ConsumerStatefulWidget {
  final TodoRouteProps routeProps;
  const TodoEditPage({super.key, required this.routeProps});

  @override
  ConsumerState<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends ConsumerState<TodoEditPage> {
  ValueNotifier<DateTime?> dateTime = ValueNotifier<DateTime?>(null);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Todo? get previousTodo {
    return widget.routeProps.todo;
  }

  @override
  void initState() {
    super.initState();
    titleController.text = previousTodo?.title ?? "";
    descriptionController.text = previousTodo?.description ?? "";
    dateTime.value = previousTodo?.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            value: widget.routeProps.useCase == TodoUseCase.add
                ? "Add Todo"
                : "Edit Todo",
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: AppTheme.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                TaskTextField(
                    controller: titleController, hintText: "Provide a name.."),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TaskTextField(
                        controller: descriptionController,
                        maxLines: 6,
                        hintText: "Enter the description..")),
                ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const CustomText(
                      value: "When you want to perform this task?",
                    ),
                    subtitle: ValueListenableBuilder<DateTime?>(
                      valueListenable: dateTime,
                      builder: (context, value, _) {
                        return CustomText(
                            value: Conversion.formatDate(dateTime.value));
                      },
                    ),
                    trailing: CustomDatePicker(
                      initialDate: widget.routeProps.todo?.dateTime,
                      onDateSelected: (value) {
                        dateTime.value = value;
                      },
                    )),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  labelText: "Save",
                  onPressed: saveButtonHandler,
                ),
              ],
            ),
          ),
        ));
  }

  void saveButtonHandler() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isNotEmpty) {
      final todo = Todo(
        id: previousTodo?.id,
        dateTime: dateTime.value,
        title: title,
        description: description,
      );
      if (todo == previousTodo) {
        context.pop();
        return;
      }
      ref
          .read(todoNotifierProvider.notifier)
          .performTodoActions(todo: todo, useCase: widget.routeProps.useCase);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(CustomSnackbar(
          message: "Please provide a Title!",
        ));
    }

    return;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
