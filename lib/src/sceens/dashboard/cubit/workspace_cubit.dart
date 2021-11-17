import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/models/workspace.dart';
import 'package:task_helper/src/task_repository.dart';

part 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  final TaskRepository taskRepository;
  final String workspaceId;

  WorkspaceCubit(
    this.taskRepository,
    this.workspaceId,
  ) : super(WorkspaceLoading()) {
    update();
  }

  Future<void> update() async {
    emit(WorkspaceLoading());

    try {
      final ws = await taskRepository.getWorkspaceById(workspaceId);
      emit(WorkspaceLoaded(ws));
    } catch (e) {
      debugPrint(e.toString());
      emit(const WorkspaceError('Something went wrong'));
    }
  }
}
