import 'workspace_property_input.dart';

class RemoveWorkspacePropertyInput {
  final String id;
  final WorkspacePropertyInput property;

  const RemoveWorkspacePropertyInput({
    required this.id,
    required this.property,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'property': property,
      };
}
