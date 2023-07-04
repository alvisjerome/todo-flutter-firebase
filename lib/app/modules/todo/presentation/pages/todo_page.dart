import 'package:app/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../widgets/primary_button.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            value: "Add Todo",
            fontSize: 20,
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
                    border: InputBorder.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
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
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                ),
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
