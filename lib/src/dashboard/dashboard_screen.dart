import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/util/color_util.dart';
import 'package:task_helper/src/workspace/workspace_list_bar.dart';
import 'package:task_helper/src/workspace/workspace_view.dart';

import 'cubit/workspace_selector_cubit.dart';
import 'profile_dialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => WorkspaceSelectorCubit(),
        child: Scaffold(
          body: Column(
            children: [
              const TopBar(),
              Expanded(
                child: Row(
                  children: [
                    const WorkspaceListBar(),
                    Expanded(
                      child: BlocBuilder<WorkspaceSelectorCubit, String?>(
                        builder: (context, state) {
                          // TODO Implement home screen
                          if (state == null) return const SizedBox.shrink();

                          return WorkspaceView(
                            key: Key(state),
                            workspaceId: state,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        elevation: 1,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () =>
                    context.read<WorkspaceSelectorCubit>().setWorkspace(null),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Center(
                    child: Text(
                      'Task Helper',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      type: MaterialType.button,
                      borderRadius: BorderRadius.circular(50),
                      clipBehavior: Clip.antiAlias,
                      color: ColorUtil.genRandomColor(
                          (context.read<AuthCubit>().state as AuthSuccess)
                              .userId
                              .hashCode),
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => const ProfileDialog(),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
