import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/workspaces_cubit.dart';
import 'package:task_helper/src/models/task.dart';
import 'package:task_helper/src/models/workspace.dart';
import 'package:task_helper/src/models/workspace_property_type.dart';
import 'package:task_helper/src/task/create_task_form.dart';
import 'package:task_helper/src/task/cubit/create_task_cubit.dart';
import 'package:task_helper/src/task/task_card.dart';
import 'package:task_helper/src/task_repository.dart';

import 'cubit/workspace_cubit.dart';

class WorkspaceView extends StatelessWidget {
  final String workspaceId;

  const WorkspaceView({
    Key? key,
    required this.workspaceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRect(
        child: BlocProvider(
          create: (context) => WorkspaceCubit(
            context.read<TaskRepository>(),
            context.read<WorkspacesCubit>(),
            workspaceId,
          ),
          child: BlocBuilder<WorkspaceCubit, WorkspaceState>(
            builder: (context, state) {
              if (state is WorkspaceLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is WorkspaceError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error),
                      Text(state.error),
                    ],
                  ),
                );
              }

              if (state is! WorkspaceLoaded) return const SizedBox.shrink();

              final ws = state.workspace;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ws.title,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                ws.description?.isNotEmpty == true
                                    ? ws.description!
                                    : 'No description',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ws.description?.isNotEmpty == true
                                          ? null
                                          : Colors.grey,
                                      fontStyle:
                                          ws.description?.isNotEmpty == true
                                              ? null
                                              : FontStyle.italic,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => BlocProvider(
                              create: (_) => CreateTaskCubit(
                                context.read<TaskRepository>(),
                                context.read<WorkspaceCubit>(),
                              ),
                              child: const CreateTaskForm(),
                            ),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('New Task'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            primary: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        PopupMenuButton(
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              child: const Text('Delete'),
                              onTap: () =>
                                  context.read<WorkspaceCubit>().delete(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: _TaskView(workspace: ws)),
                  ],
                ),
              );
            },
          ),
        ),
      );
}

class _TaskView extends StatefulWidget {
  final Workspace workspace;

  const _TaskView({Key? key, required this.workspace}) : super(key: key);

  @override
  State<_TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<_TaskView> {
  final scrollc = ScrollController();

  @override
  void dispose() {
    scrollc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusProp = widget.workspace.properties!['Status'];

    if (statusProp == null || statusProp.type != WorkspacePropertyType.select) {
      return GridView.extent(
        padding: const EdgeInsets.symmetric(vertical: 20),
        maxCrossAxisExtent: 200,
        shrinkWrap: true,
        children:
            widget.workspace.tasks!.map((e) => TaskCard(task: e)).toList(),
        childAspectRatio: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      );
    }

    final vals = statusProp.values;
    final undefTasks = widget.workspace.tasks!
        .where((t) => !vals.contains(t.properties['Status']));

    return Scrollbar(
      controller: scrollc,
      isAlwaysShown: true,
      scrollbarOrientation: ScrollbarOrientation.top,
      showTrackOnHover: true,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.horizontal,
        controller: scrollc,
        clipBehavior: Clip.none,
        itemCount: statusProp.values.length + (undefTasks.isNotEmpty ? 1 : 0),
        itemBuilder: (context, index) {
          final trueIndex = undefTasks.isNotEmpty ? index - 1 : index;
          final tasks = trueIndex == -1
              ? undefTasks.toList()
              : widget.workspace.tasks!
                  .where((t) => t.properties['Status'] == vals[trueIndex])
                  .toList();

          return SizedBox(
            width: 200,
            child: _BucketView(
              title: trueIndex == -1 ? 'Undefined Status' : vals[trueIndex],
              tasks: tasks,
            ),
          );
        },
      ),
    );
  }
}

class _BucketView extends StatefulWidget {
  final String title;
  final List<Task> tasks;

  const _BucketView({
    Key? key,
    required this.title,
    required this.tasks,
  }) : super(key: key);

  @override
  State<_BucketView> createState() => _BucketViewState();
}

class _BucketViewState extends State<_BucketView> {
  final scrollc = ScrollController();

  @override
  void dispose() {
    scrollc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scrollbar(
        controller: scrollc,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: DragTarget<String>(
          onAccept: (taskId) => context
              .read<WorkspaceCubit>()
              .setPropertyValue(taskId, 'Status', widget.title),
          builder: (context, candidateData, _) => Material(
            borderRadius: BorderRadius.circular(5),
            color: candidateData.isNotEmpty
                ? Colors.grey.shade400
                : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                controller: scrollc,
                shrinkWrap: true,
                itemCount: widget.tasks.length + 1,
                itemBuilder: (context, tindex) => tindex == 0
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Draggable(
                        data: widget.tasks[tindex - 1].id,
                        feedback: SizedBox(
                          height: 200 / 3,
                          width: 200,
                          child: TaskCard(task: widget.tasks[tindex - 1]),
                        ),
                        child: AspectRatio(
                          aspectRatio: 3,
                          child: TaskCard(task: widget.tasks[tindex - 1]),
                        ),
                      ),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
              ),
            ),
          ),
        ),
      );
}
