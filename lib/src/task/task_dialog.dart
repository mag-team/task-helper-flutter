import 'package:flutter/material.dart';
import 'package:task_helper/src/models/task.dart';

class TaskDialog extends StatelessWidget {
  final Task task;

  const TaskDialog({
    Key? key,
    required this.task,
  }) : super(key: key);

  // TODO Implement
  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      );
}
