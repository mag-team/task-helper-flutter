import 'package:equatable/equatable.dart';

import 'task.dart';
import 'user.dart';

class Workspace extends Equatable {
  final String id;
  final User? owner;
  final String title;
  final List<User>? members;
  final List<Task>? tasks;

  const Workspace({
    required this.id,
    required this.title,
    this.owner,
    this.members,
    this.tasks,
  });

  Workspace.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        owner = map['owner'] != null ? User.fromJson(map['owner']) : null,
        title = map['title'],
        members = map['members'] != null
            ? (map['members'] as List).map((e) => User.fromJson(e)).toList()
            : null,
        tasks = map['tasks'] != null
            ? (map['tasks'] as List).map((e) => Task.fromJson(e)).toList()
            : null;

  Workspace copyWith({
    String? id,
    String? title,
    User? owner,
    List<User>? members,
    List<Task>? tasks,
  }) =>
      Workspace(
        id: id ?? this.id,
        title: title ?? this.title,
        owner: owner ?? this.owner,
        members: members ?? this.members,
        tasks: tasks ?? this.tasks,
      );

  @override
  List<Object?> get props => [id, owner, title, members, tasks];
}
