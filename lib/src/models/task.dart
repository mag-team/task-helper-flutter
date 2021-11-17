import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String workspace;
  final String? parentTask;

  const Task(this.id, this.title, this.workspace, this.parentTask);

  Task.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        workspace = map['workspace'],
        parentTask = map['parentTask'];

  @override
  List<Object?> get props => [id, title, workspace, parentTask];
}
