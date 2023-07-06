import 'package:app/app/modules/todo/datasource/models/todo.dart';
import 'package:app/app/modules/todo/presentation/widgets/task_textfield.dart';
import 'package:app/core/utils/conversion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../../core/utils/request_handlers.dart';
import '../../../../../core/utils/typedefs.dart';
import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../providers/todo_provider.dart';

class TodoEditPage extends StatefulWidget {
  final TodoRouteProps routeProps;
  const TodoEditPage({super.key, required this.routeProps});

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
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

  void saveButtonHandler() {
    final Todo todo = Todo(
      id: widget.routeProps.todo?.id,
      dateTime: dateTime.value,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
    );
    context
        .read<TodoProvider>()
        .handleAddOrEdit(
            useCase: widget.routeProps.useCase,
            todo: todo,
            handlers: RequestHandlers(
              onError: ([message]) => Helpers.onErrorSnackbar(message, context),
              onSuccess: () => Helpers.onSuccessSnackbar(context),
              onLoading: () => Helpers.onLoadingSnackbar(context),
            ))
        .then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            value: widget.routeProps.useCase == TodoUseCase.addTodo
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

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
