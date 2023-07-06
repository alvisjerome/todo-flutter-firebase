import 'package:app/core/common/image_paths.dart';

import '../providers/todo_provider.dart';
import '../../../../../core/enums/todo_usecase.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/app_paths.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/custom_text.dart';
import '../../datasource/models/todo.dart';
import '../widgets/task_tile.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todosProvider = context.read<TodoProvider>();
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
      body: StreamBuilder<List<Todo>>(
          stream: todosProvider.getAllTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  child: CustomText(value: "${snapshot.error}"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final todos = snapshot.data;
              if (todos?.isEmpty ?? false) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Image.asset(
                            ImagePaths.emptyTodos,
                          ),
                        ),
                        const CustomText(
                          align: TextAlign.center,
                          value:
                              "You have no todos. To add more click on the button at the bottom",
                        )
                      ],
                    ),
                  ),
                );
              }

              return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15),
                  itemCount: todos?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return TaskTile(todo: todos?[index]);
                  });
            }
            return const SizedBox();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const record = (useCase: TodoUseCase.addTodo, todo: null);
          Navigator.pushNamed(context, AppPaths.editTodo, arguments: record);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
