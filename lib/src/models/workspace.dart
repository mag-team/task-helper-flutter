import 'package:equatable/equatable.dart';

import 'task.dart';
import 'user.dart';
import 'workspace_property.dart';

class Workspace extends Equatable {
  final String id;
  final User? owner;
  final String title;
  final String? description;
  final List<User>? members;
  final List<Task>? tasks;
  final List<WorkspaceProperty>? properties;

  const Workspace({
    required this.id,
    required this.title,
    this.description,
    this.owner,
    this.members,
    this.tasks,
    this.properties,
  });

  Workspace.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        owner = json['owner'] != null ? User.fromJson(json['owner']) : null,
        title = json['title'],
        description = json['description'],
        members = json['members'] != null
            ? (json['members'] as List).map((e) => User.fromJson(e)).toList()
            : null,
        tasks = json['tasks'] != null
            ? (json['tasks'] as List).map((e) => Task.fromJson(e)).toList()
            : null,
        properties = json['properties'] != null
            ? (json['properties'] as List)
                .map((e) => WorkspaceProperty.fromJson(e))
                .toList()
            : null;

  Workspace copyWith({
    String? id,
    String? title,
    String? description,
    User? owner,
    List<User>? members,
    List<Task>? tasks,
    List<WorkspaceProperty>? properties,
  }) =>
      Workspace(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        owner: owner ?? this.owner,
        members: members ?? this.members,
        tasks: tasks ?? this.tasks,
        properties: properties ?? this.properties,
      );

  @override
  List<Object?> get props =>
      [id, owner, title, description, members, tasks, properties];
}
