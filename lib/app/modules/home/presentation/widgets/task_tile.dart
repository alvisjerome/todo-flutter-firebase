import 'package:app/app/modules/home/presentation/widgets/task_menu.dart';
import 'package:app/app/widgets/custom_text.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightPink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CustomText(
                  value: "Shopping Grocery",
                  fontWeight: FontWeight.bold,
                ),
              )),
              TaskMenu()
            ],
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, top: 5, right: 10),
              child: CustomText(
                maxLine: 4,
                value:
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5, bottom: 3.0),
            child: CustomText(
              value: "4th April 2023",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
