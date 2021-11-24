import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String workspace;
  final String? parentTask;

  const Task({
    required this.id,
    required this.title,
    required this.workspace,
    this.parentTask,
  });

  Task.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        workspace = map['workspace'],
        parentTask = map['parentTask'];

  Task copyWith({
    String? id,
    String? title,
    String? workspace,
    String? parentTask,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        workspace: workspace ?? this.workspace,
        parentTask: parentTask ?? this.parentTask,
      );

  @override
  List<Object?> get props => [id, title, workspace, parentTask];
}
