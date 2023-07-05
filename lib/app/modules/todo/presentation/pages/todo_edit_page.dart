import 'package:app/core/enums/todo_usecase.dart';

import '../../../../widgets/custom_date_picker.dart';
import '../../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../widgets/primary_button.dart';

class TodoEditPage extends StatefulWidget {
  final TodoUseCase? useCase;
  const TodoEditPage({super.key, required this.useCase});

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            value: widget.useCase == TodoUseCase.addTodo
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
                  textInputAction: TextInputAction.done,
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
                    textInputAction: TextInputAction.done,
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
                    subtitle: const CustomText(value: "23 July, 2023"),
                    trailing: CustomDatePicker(
                      onDateSelected: (value) {},
                    )),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  labelText: "Save",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
