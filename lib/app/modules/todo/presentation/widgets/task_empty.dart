import 'package:flutter/material.dart';

import '../../../../../core/common/image_paths.dart';
import '../../../../widgets/custom_text.dart';

class TaskEmptyWidget extends StatelessWidget {
  const TaskEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}
