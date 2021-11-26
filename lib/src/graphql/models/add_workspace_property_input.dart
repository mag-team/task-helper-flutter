import 'workspace_property_input.dart';

class AddWorkspacePropertyInput {
  final String id;
  final WorkspacePropertyInput property;

  const AddWorkspacePropertyInput({
    required this.id,
    required this.property,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'property': property,
      };
}
