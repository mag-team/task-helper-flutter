import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/cubit/workspaces_cubit.dart';
import 'package:task_helper/src/models/form_status.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/task_repository.dart';

part 'create_workspace_state.dart';

class CreateWorkspaceCubit extends Cubit<CreateWorkspaceState> {
  final TaskRepository taskRepository;
  final WorkspacesCubit workspacesCubit;

  CreateWorkspaceCubit(
    this.taskRepository,
    this.workspacesCubit,
  ) : super(const CreateWorkspaceState());

  void setTitle(String value) {
    emit(state.copyWith(title: value));
  }

  void setDescription(String value) {
    emit(state.copyWith(description: value));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: FormStatus.inProgress));

    try {
      final workspace =
          await taskRepository.createWorkspace(CreateWorkspaceInput(
        title: state.title,
        description: state.description.isNotEmpty ? state.description : null,
      ));
      workspacesCubit.addWorkspace(workspace);
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormStatus.failed));
    }
  }
}
