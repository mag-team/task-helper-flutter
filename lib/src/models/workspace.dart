import 'package:equatable/equatable.dart';

import 'task.dart';
import 'user.dart';

class Workspace extends Equatable {
  final String id;
  final User? owner;
  final String title;
  final List<User>? members;
  final List<Task>? tasks;

  const Workspace(this.id, this.owner, this.title, this.members, this.tasks);

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

  @override
  List<Object?> get props => [id, owner, title, members, tasks];
}
