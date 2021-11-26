import 'package:equatable/equatable.dart';

class TaskProperty extends Equatable {
  final String name;
  final String? value;

  const TaskProperty({
    required this.name,
    this.value,
  });

  TaskProperty.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];

  @override
  List<Object?> get props => [name, value];
}
