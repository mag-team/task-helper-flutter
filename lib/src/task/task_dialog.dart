import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/models/task.dart';
import 'package:task_helper/src/task_repository.dart';
import 'package:task_helper/src/workspace/cubit/workspace_cubit.dart';

import 'create_task_form.dart';
import 'cubit/create_task_cubit.dart';

class TaskDialog extends StatelessWidget {
  final String? previousTask;
  final Task task;

  const TaskDialog({
    Key? key,
    this.previousTask,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subTheme = textTheme.subtitle1?.copyWith(color: Colors.grey);

    final subTasks = (context.watch<WorkspaceCubit>().state as WorkspaceLoaded)
        .workspace
        .tasks!
        .where((t) => t.parentTask == task.id)
        .toList();

    final parentTask = task.parentTask != null
        ? (context.watch<WorkspaceCubit>().state as WorkspaceLoaded)
            .workspace
            .tasks!
            .firstWhere((t) => t.id == task.parentTask)
        : null;

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(
          minWidth: 1000,
          maxWidth: 1000,
          maxHeight: 600,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: textTheme.headline5,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Delete'),
                      // TODO Implement delete
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
            if (parentTask != null) ...[
              const SizedBox(height: 10),
              Text('Parent Task', style: subTheme),
              _TaskButton(
                task: parentTask,
                prevoiusTask: previousTask,
                currentTask: task.id,
              ),
            ],
            const SizedBox(height: 10),
            Text('Properties', style: subTheme),
            if (task.properties.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'No Properties',
                    style: subTheme?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: task.properties.length,
                itemBuilder: (context, index) {
                  final prop = task.properties[index];
                  return Text('${prop.name} : ${prop.value}');
                },
              ),
            const SizedBox(height: 10),
            Text('Sub Tasks', style: subTheme),
            if (subTasks.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'No Sub Tasks',
                    style: subTheme?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: subTasks.length,
                itemBuilder: (context, index) => _TaskButton(
                  task: subTasks[index],
                  prevoiusTask: previousTask,
                  currentTask: task.id,
                ),
              ),
            TextButton.icon(
              // TODO Implement link task
              onPressed: () {},
              icon: const Icon(Icons.link),
              label: const Text('Link Existing Task'),
            ),
            TextButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => BlocProvider(
                  create: (_) => CreateTaskCubit(
                    context.read<TaskRepository>(),
                    context.read<WorkspaceCubit>(),
                    parentTask: task.id,
                  ),
                  child: const CreateTaskForm(),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Create New Task'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskButton extends StatelessWidget {
  final String? prevoiusTask;
  final String currentTask;
  final Task task;

  const _TaskButton({
    Key? key,
    this.prevoiusTask,
    required this.currentTask,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: prevoiusTask == task.id
            ? () => Navigator.pop(context)
            : () => showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: context.read<WorkspaceCubit>(),
                    child: TaskDialog(
                      task: task,
                      previousTask: currentTask,
                    ),
                  ),
                ),
        child: Text(task.title),
        style: TextButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
}
