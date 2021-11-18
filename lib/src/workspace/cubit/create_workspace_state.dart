part of 'create_workspace_cubit.dart';

class CreateWorkspaceState extends Equatable {
  final FormStatus status;
  final String title;

  const CreateWorkspaceState({
    this.status = FormStatus.none,
    this.title = '',
  });

  CreateWorkspaceState copyWith({
    FormStatus status = FormStatus.none,
    String? title,
  }) =>
      CreateWorkspaceState(
        status: status,
        title: title ?? this.title,
      );

  @override
  List<Object?> get props => [status, title];
}
