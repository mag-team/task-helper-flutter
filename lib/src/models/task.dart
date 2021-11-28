import 'package:equatable/equatable.dart';
import 'package:task_helper/src/models/task_property.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String workspace;
  final String? parentTask;
  final Map<String, String?> properties;

  const Task({
    required this.id,
    required this.title,
    required this.workspace,
    this.parentTask,
    required this.properties,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        workspace = json['workspace'],
        parentTask = json['parentTask'],
        properties = Map.fromEntries((json['properties'] as List? ?? [])
            .map((e) => TaskProperty.fromJson(e))
            .map((e) => MapEntry(e.name, e.value)));

  Task copyWith({
    String? id,
    String? title,
    String? workspace,
    String? parentTask,
    Map<String, String?>? properties,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        workspace: workspace ?? this.workspace,
        parentTask: parentTask ?? this.parentTask,
        properties: properties ?? this.properties,
      );

  @override
  List<Object?> get props => [id, title, workspace, parentTask, properties];
}
