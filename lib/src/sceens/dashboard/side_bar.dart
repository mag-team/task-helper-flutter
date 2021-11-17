import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/workspaces_cubit.dart';
import 'package:task_helper/src/models/workspace.dart';

import 'cubit/workspace_selector_cubit.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: Material(
        elevation: 1,
        child: BlocBuilder<WorkspacesCubit, WorkspacesState>(
          builder: (context, state) {
            final ws =
                state is WorkspacesLoaded ? state.workspaces : <Workspace>[];

            return ListView.builder(
              itemCount: ws.length + 1,
              itemBuilder: (context, index) {
                if (index == ws.length) {
                  return SidebarButton(
                    tooltip: 'New Workspace',
                    child: const Icon(Icons.add),
                    primaryColor: Colors.green.shade300,
                    onPressed: () {},
                  );
                }

                return SidebarButton(
                  tooltip: ws[index].title,
                  child: Text(ws[index].title.characters.first),
                  onPressed: () =>
                      context.read<WorkspaceSelectorCubit>().emit(ws[index].id),
                  isSelected: ws[index].id ==
                      context.watch<WorkspaceSelectorCubit>().state,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final String tooltip;
  final Color? primaryColor;
  final bool isSelected;

  const SidebarButton({
    Key? key,
    this.onPressed,
    required this.child,
    required this.tooltip,
    this.primaryColor,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Tooltip(
          message: tooltip,
          child: AspectRatio(
            aspectRatio: 1,
            child: ElevatedButton(
              onPressed: onPressed,
              child: child,
              style: ElevatedButton.styleFrom(
                primary: primaryColor ?? Colors.blue.shade400,
                padding: const EdgeInsets.all(0),
                textStyle: Theme.of(context).textTheme.subtitle1,
              ).copyWith(
                shape: MaterialStateProperty.resolveWith((states) =>
                    isSelected || states.contains(MaterialState.hovered)
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                        : const CircleBorder()),
              ),
            ),
          ),
        ),
      );
}
