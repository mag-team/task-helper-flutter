part of 'workspaces_cubit.dart';

abstract class WorkspacesState extends Equatable {
  const WorkspacesState();

  @override
  List<Object?> get props => [];
}

class WorkspacesInitial extends WorkspacesState {}

class WorkspacesLoading extends WorkspacesState {}

class WorkspacesLoaded extends WorkspacesState {
  final List<Workspace> workspaces;

  const WorkspacesLoaded(this.workspaces);

  @override
  List<Object?> get props => [workspaces];
}

class WorkspacesError extends WorkspacesState {
  final String error;

  const WorkspacesError(this.error);

  @override
  List<Object?> get props => [error];
}
