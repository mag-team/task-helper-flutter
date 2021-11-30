import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/cubit/workspaces_cubit.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/models/task.dart';
import 'package:task_helper/src/models/workspace.dart';
import 'package:task_helper/src/models/workspace_property_type.dart';
import 'package:task_helper/src/task_repository.dart';

part 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  final TaskRepository taskRepository;
  final WorkspacesCubit workspacesCubit;
  final String workspaceId;

  WorkspaceCubit(
    this.taskRepository,
    this.workspacesCubit,
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

  void addTask(Task task) {
    final ws = (state as WorkspaceLoaded).workspace;
    final tasks = List.of(ws.tasks!)..add(task);

    emit(WorkspaceLoaded(ws.copyWith(tasks: tasks)));
  }

  void deleteTask(String id) {
    final ws = (state as WorkspaceLoaded).workspace;
    final tasks = List.of(ws.tasks!)..removeWhere((t) => t.id == id);
    taskRepository.removeTask(id);

    emit(WorkspaceLoaded(ws.copyWith(tasks: tasks)));
  }

  void delete() {
    emit(WorkspaceInitial());
    taskRepository.removeWorkspace(workspaceId);
    workspacesCubit.removeWorkspace(workspaceId);
  }

  Future<void> addProperty() async {
    final props = (state as WorkspaceLoaded).workspace.properties!;
    int i;
    for (i = 1; true; ++i) {
      if (!props.containsKey('Property $i')) break;
    }

    final ws = await taskRepository.addWorkspaceProperty(
      AddWorkspacePropertyInput(
        id: workspaceId,
        property: WorkspacePropertyInput(
          name: 'Property $i',
          type: WorkspacePropertyType.text.name,
        ),
      ),
    );

    emit(WorkspaceLoaded(ws));
  }

  Future<void> setPropertyName(String property, String value) async {
    final ws = await taskRepository.updateWorkspaceProperty(
      UpdateWorkspacePropertyInput(
        id: workspaceId,
        propertyOldName: property,
        propertyNewName: value,
      ),
    );

    emit(WorkspaceLoaded(ws));
  }

  Future<void> removeProperty(String property) async {
    final ws = await taskRepository.removeWorkspaceProperty(
      RemoveWorkspacePropertyInput(
        id: workspaceId,
        propertyName: property,
      ),
    );

    emit(WorkspaceLoaded(ws));
  }

  Future<void> setPropertyType(
      String property, WorkspacePropertyType type) async {
    final ws = await taskRepository.updateWorkspaceProperty(
      UpdateWorkspacePropertyInput(
          id: workspaceId,
          propertyOldName: property,
          propertyNewType: type.name),
    );

    emit(WorkspaceLoaded(ws));
  }

  Future<void> setPropertyValue(
      String taskId, String property, String value) async {
    final task = await taskRepository.updateTaskProperty(
      UpdateTaskPropertyInput(
        id: taskId,
        property: TaskPropertyInput(
          name: property,
          value: value,
        ),
      ),
    );

    final ws = (state as WorkspaceLoaded).workspace;
    final tIndex = ws.tasks!.indexWhere((t) => t.id == taskId);
    final tasks = List.of(ws.tasks!);
    tasks[tIndex] = task;

    emit(WorkspaceLoaded(ws.copyWith(tasks: tasks)));
  }

  Future<void> addSelectValue(String property, String value) async {
    final prop = (state as WorkspaceLoaded).workspace.properties![property];
    if (prop == null || prop.values.contains(value)) return;

    final ws = await taskRepository.addValueToWorkspaceProperty(
      AddValueToWorkspacePropertyInput(
        id: workspaceId,
        propertyName: property,
        value: value,
      ),
    );

    emit(WorkspaceLoaded(ws));
  }

  Future<void> removeSelectValue(String property, String value) async {
    final ws = await taskRepository.removeValueFromWorkspaceProperty(
      RemoveValueFromWorkspacePropertyInput(
        id: workspaceId,
        propertyName: property,
        value: value,
      ),
    );

    emit(WorkspaceLoaded(ws));
  }
}
