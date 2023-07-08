import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/conversion.dart';
import '../../../../widgets/custom_text.dart';
import '../../datasource/models/todo.dart';
import 'task_menu.dart';

class TaskTile extends StatelessWidget {
  final Todo? todo;

  const TaskTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.randomColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: CustomText(
                    value: todo?.title ?? "",
                    fontWeight: FontWeight.bold,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              TaskMenu(todo: todo)
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10),
              child: CustomText(
                maxLine: 4,
                value: todo?.description ?? "",
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 3.0),
            child: CustomText(
              value: Conversion.formatDate(todo?.dateTime),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
