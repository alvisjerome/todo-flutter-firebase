import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/snackbar_types.dart';
import '../../../../../core/enums/todo_usecase.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/custom_text.dart';
import '../providers/todo_providers.dart';
import '../widgets/task_empty.dart';
import '../widgets/task_tile.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      todoNotifierProvider,
      (_, next) {
        final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();

        next.whenOrNull(
          loading: () {
            messenger.showSnackBar(CustomSnackbar(type: SnackbarType.loading));
          },
          error: (error, stackTrace) {
            messenger.showSnackBar(CustomSnackbar(
              type: SnackbarType.error,
              message: error.toString(),
            ));
          },
          data: (data) {
            messenger.showSnackBar(CustomSnackbar(
              type: SnackbarType.success,
              message: "Task has been deleted successfully!",
            ));
          },
        );
      },
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                onPressed: () => context.goNamed(RouteNames.profile.name),
                icon: const Icon(
                  Icons.account_circle,
                ))
          ],
        ),
        body: Consumer(builder: (context, ref, _) {
          final todos = ref.watch(getTodosProvider);

          return todos.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            data: (todos) {
              return (todos.isEmpty)
                  ? const TaskEmptyWidget()
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15),
                      itemCount: todos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return TaskTile(todo: todos[index]);
                      });
            },
            error: (error, stacktrace) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  child: CustomText(value: "$error"));
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            const record = (useCase: TodoUseCase.add, todo: null);
            context.goNamed(RouteNames.editTodo.name, extra: record);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
