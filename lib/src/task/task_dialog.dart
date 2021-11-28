import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/models/task.dart';
import 'package:task_helper/src/models/workspace_property.dart';
import 'package:task_helper/src/models/workspace_property_type.dart';
import 'package:task_helper/src/task_repository.dart';
import 'package:task_helper/src/workspace/cubit/workspace_cubit.dart';

import 'create_task_form.dart';
import 'cubit/create_task_cubit.dart';

class TaskDialog extends StatelessWidget {
  final String? previousTask;
  final String taskId;

  const TaskDialog({
    Key? key,
    this.previousTask,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, workspaceState) {
          workspaceState as WorkspaceLoaded;
          final task =
              workspaceState.workspace.tasks!.firstWhere((t) => t.id == taskId);

          final textTheme = Theme.of(context).textTheme;
          final subTheme = textTheme.subtitle1?.copyWith(color: Colors.grey);

          final subTasks = workspaceState.workspace.tasks!
              .where((t) => t.parentTask == task.id)
              .toList();

          final parentTask = task.parentTask != null
              ? workspaceState.workspace.tasks!
                  .firstWhere((t) => t.id == task.parentTask)
              : null;

          final properties = workspaceState.workspace.properties!;

          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(50),
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
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            child: const Text('Delete'),
                            onTap: () {
                              context
                                  .read<WorkspaceCubit>()
                                  .deleteTask(task.id);
                              Navigator.pop(context);
                            },
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
                  if (properties.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'No Properties',
                          style:
                              subTheme?.copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                  else
                    _PropTable(
                      task: task,
                      properties: properties,
                    ),
                  TextButton.icon(
                    onPressed: () =>
                        context.read<WorkspaceCubit>().addProperty(),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Property'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Sub Tasks', style: subTheme),
                  if (subTasks.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'No Sub Tasks',
                          style:
                              subTheme?.copyWith(fontStyle: FontStyle.italic),
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
        },
      );
}

class _PropTable extends StatelessWidget {
  final List<WorkspaceProperty> properties;
  final Task task;

  const _PropTable({
    Key? key,
    required this.properties,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Table(
        columnWidths: const {
          0: FractionColumnWidth(0.30),
        },
        children: properties.map((e) {
          final val = task.properties[e.name] ?? '';
          return TableRow(
            children: [
              IconTheme(
                data: const IconThemeData(size: 20),
                child: PopupMenuButton<void>(
                  itemBuilder: (popCt) => [
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                        ),
                        style: Theme.of(context).textTheme.bodyText2,
                        initialValue: e.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == e.name) return null;
                          if (properties.any((p) => p.name == value)) {
                            return 'Another property with this name already exists';
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (value == e.name ||
                              properties.any((p) => p.name == value)) {
                            return;
                          }

                          context
                              .read<WorkspaceCubit>()
                              .setPropertyName(e.name, value);
                        },
                      ),
                      enabled: false,
                    ),
                    PopupMenuItem(
                      height: 0,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'PROPERTY TYPE',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                      enabled: false,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          e.type.icon,
                          const SizedBox(width: 5),
                          Text(e.type.name),
                        ],
                      ),
                      // TODO Implement
                      onTap: () {},
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 5),
                          Text('Delete property'),
                        ],
                      ),
                      onTap: () =>
                          context.read<WorkspaceCubit>().removeProperty(e.name),
                    ),
                  ],
                  tooltip: '',
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      e.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  isDense: true,
                  hintText: 'Empty',
                ),
                style: Theme.of(context).textTheme.bodyText2,
                initialValue: val,
                onFieldSubmitted: (value) {
                  if (value == val) return;

                  context
                      .read<WorkspaceCubit>()
                      .setPropertyValue(task.id, e.name, value);
                  // Navigator.pop(itC);
                },
              ),
            ],
          );
        }).toList(),
      );
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
                      taskId: task.id,
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
