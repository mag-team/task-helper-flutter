class RemoveWorkspacePropertyInput {
  final String id;
  final String propertyName;

  const RemoveWorkspacePropertyInput({
    required this.id,
    required this.propertyName,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'propertyName': propertyName,
      };
}
