part of 'create_workspace_cubit.dart';

class CreateWorkspaceState extends Equatable {
  final FormStatus status;
  final String title;
  final String description;

  const CreateWorkspaceState({
    this.status = FormStatus.none,
    this.title = '',
    this.description = '',
  });

  CreateWorkspaceState copyWith({
    FormStatus status = FormStatus.none,
    String? title,
    String? description,
  }) =>
      CreateWorkspaceState(
        status: status,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  @override
  List<Object?> get props => [status, title, description];
}
