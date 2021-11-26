import 'package:equatable/equatable.dart';

class WorkspaceProperty extends Equatable {
  final String name;
  final String type;
  final List<String> values;

  const WorkspaceProperty({
    required this.name,
    required this.type,
    required this.values,
  });

  WorkspaceProperty.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        values = json['values'];

  @override
  List<Object?> get props => [name, type, values];
}
