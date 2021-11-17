import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/task_repository.dart';

import 'cubit/workspace_cubit.dart';

class WorkspaceView extends StatelessWidget {
  final String workspaceId;

  const WorkspaceView({
    Key? key,
    required this.workspaceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => WorkspaceCubit(
          context.read<TaskRepository>(),
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

            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ws.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('New Task'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        primary: Colors.green,
                      ),
                    )
                  ],
                ),
                GridView.extent(
                  padding: const EdgeInsets.all(20),
                  maxCrossAxisExtent: 300,
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: ws.tasks!.map((e) => const Card()).toList(),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
}
