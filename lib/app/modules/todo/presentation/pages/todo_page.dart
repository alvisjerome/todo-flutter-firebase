import 'package:app/core/enums/todo_usecase.dart';

import '../../../../../core/routes/app_paths.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/custom_text.dart';
import '../widgets/task_tile.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          value: "Todos",
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppTheme.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppPaths.profile);
              },
              icon: const Icon(
                Icons.account_circle,
              ))
        ],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return const TaskTile();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppPaths.editTodo,
            arguments: TodoUseCase.addTodo),
        child: const Icon(Icons.add),
      ),
    );
  }
}
