import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String workspace;
  final String parentTask;

  const Task(this.id, this.title, this.workspace, this.parentTask);

  @override
  List<Object?> get props => [id, title, workspace, parentTask];
}
