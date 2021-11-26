part of 'create_task_cubit.dart';

class CreateTaskState extends Equatable {
  final FormStatus status;
  final String title;
  final String? parentTask;

  const CreateTaskState({
    this.status = FormStatus.none,
    this.title = '',
    this.parentTask,
  });

  CreateTaskState copyWith({
    FormStatus status = FormStatus.none,
    String? title,
  }) =>
      CreateTaskState(
        status: status,
        title: title ?? this.title,
        parentTask: parentTask,
      );

  @override
  List<Object?> get props => [status, title];
}
