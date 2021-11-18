import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/models/workspace.dart';
import 'package:task_helper/src/task_repository.dart';

part 'workspaces_state.dart';

class WorkspacesCubit extends Cubit<WorkspacesState> {
  final TaskRepository taskRepository;

  WorkspacesCubit(this.taskRepository) : super(WorkspacesInitial()) {
    update();
  }

  Future<void> update() async {
    emit(WorkspacesLoading());

    try {
      final workspaces = await taskRepository.getWorkspaces();
      emit(WorkspacesLoaded(workspaces));
    } catch (e) {
      debugPrint(e.toString());
      emit(const WorkspacesError('Something went wrong'));
    }
  }

  void addWorkspace(Workspace workspace) {
    final wList = List.of((state as WorkspacesLoaded).workspaces)
      ..add(workspace);
    emit(WorkspacesLoaded(wList));
  }
}
