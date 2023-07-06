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
  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();

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
                TextField(
                  controller: todoProvider.titleController,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.body,
                  decoration: InputDecoration(
                    hintText: "Provide a name..",
                    hintStyle: Theme.of(context).textTheme.body.copyWith(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppTheme.lightPink,
                    border: InputBorder.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: todoProvider.descriptionController,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.body,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Enter the description..",
                      hintStyle: Theme.of(context).textTheme.body.copyWith(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: AppTheme.lightPink,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const CustomText(
                      value: "When you want to perform this task?",
                    ),
                    subtitle: Consumer<TodoProvider>(
                      builder: (context, value, _) {
                        return CustomText(
                            value: todoProvider.getDateTime(
                                useCase: widget.routeProps.useCase,
                                todo: widget.routeProps.todo));
                      },
                    ),
                    trailing: CustomDatePicker(
                      initialDate: widget.routeProps.todo?.dateTime,
                      onDateSelected: (value) {
                        todoProvider.dateTime = value;
                      },
                    )),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  labelText: "Save",
                  onPressed: () => todoProvider
                      .handleAddOrEdit(
                          useCase: widget.routeProps.useCase,
                          id: widget.routeProps.todo?.id,
                          handlers: RequestHandlers(
                            onError: ([message]) =>
                                Helpers.onErrorSnackbar(message, context),
                            onSuccess: () => Helpers.onSuccessSnackbar(context),
                            onLoading: () => Helpers.onLoadingSnackbar(context),
                          ))
                      .then((value) {
                    Navigator.pop(context);
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
