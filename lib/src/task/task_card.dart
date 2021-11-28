import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/models/task.dart';
import 'package:task_helper/src/task/task_dialog.dart';
import 'package:task_helper/src/workspace/cubit/workspace_cubit.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key ?? Key(task.id));

  @override
  Widget build(BuildContext context) => Tooltip(
        message: task.title,
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<WorkspaceCubit>(),
                child: TaskDialog(taskId: task.id),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                task.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
      );
}
