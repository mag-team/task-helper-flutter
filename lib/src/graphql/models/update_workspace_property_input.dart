class UpdateWorkspacePropertyInput {
  final String id;
  final String propertyOldName;
  final String? propertyNewName;
  final String? propertyNewType;

  const UpdateWorkspacePropertyInput({
    required this.id,
    required this.propertyOldName,
    this.propertyNewName,
    this.propertyNewType,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'propertyOldName': propertyOldName,
        if (propertyNewName != null) 'propertyNewName': propertyNewName,
        if (propertyNewType != null) 'propertyNewType': propertyNewType,
      };
}
