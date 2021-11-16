import 'package:equatable/equatable.dart';

import 'task.dart';
import 'user.dart';

class Workspace extends Equatable {
  final String id;
  final User owner;
  final String title;
  final List<User> members;
  final List<Task> tasks;

  const Workspace(this.id, this.owner, this.title, this.members, this.tasks);

  @override
  List<Object?> get props => [id, owner, title, members, tasks];
}
