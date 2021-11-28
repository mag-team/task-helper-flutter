import 'package:equatable/equatable.dart';

import 'workspace_property_type.dart';

class WorkspaceProperty extends Equatable {
  final String name;
  final WorkspacePropertyType type;
  // TODO Remove after fix
  final List<String>? values;

  const WorkspaceProperty({
    required this.name,
    required this.type,
    required this.values,
  });

  WorkspaceProperty.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = WorkspacePropertyType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => WorkspacePropertyType.text,
        ),
        values = json['values'];

  @override
  List<Object?> get props => [name, type, values];
}
