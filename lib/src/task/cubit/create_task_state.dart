part of 'create_task_cubit.dart';

class CreateTaskState extends Equatable {
  final FormStatus status;
  final String title;

  const CreateTaskState({
    this.status = FormStatus.none,
    this.title = '',
  });

  CreateTaskState copyWith({
    FormStatus status = FormStatus.none,
    String? title,
  }) =>
      CreateTaskState(
        status: status,
        title: title ?? this.title,
      );

  @override
  List<Object?> get props => [status, title];
}
