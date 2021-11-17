part of 'workspace_cubit.dart';

abstract class WorkspaceState extends Equatable {
  const WorkspaceState();

  @override
  List<Object?> get props => [];
}

class WorkspaceInitial extends WorkspaceState {}

class WorkspaceLoading extends WorkspaceState {}

class WorkspaceLoaded extends WorkspaceState {
  final Workspace workspace;

  const WorkspaceLoaded(this.workspace);

  @override
  List<Object?> get props => [workspace];
}

class WorkspaceError extends WorkspaceState {
  final String error;

  const WorkspaceError(this.error);

  @override
  List<Object?> get props => [error];
}
