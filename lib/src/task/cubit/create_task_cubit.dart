import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/form_status.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/task_repository.dart';
import 'package:task_helper/src/workspace/cubit/workspace_cubit.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final TaskRepository taskRepository;
  final WorkspaceCubit workspaceCubit;

  CreateTaskCubit(
    this.taskRepository,
    this.workspaceCubit, {
    String? parentTask,
  }) : super(CreateTaskState(parentTask: parentTask));

  void setTitle(String value) {
    emit(state.copyWith(title: value));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: FormStatus.inProgress));

    try {
      final task = await taskRepository.createTask(CreateTaskInput(
        title: state.title,
        workspace: workspaceCubit.workspaceId,
        parentTask: state.parentTask,
      ));

      workspaceCubit.addTask(task);
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormStatus.failed));
    }
  }
}
