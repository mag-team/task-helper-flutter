class RemoveValueFromWorkspacePropertyInput {
  final String id;
  final String propertyName;
  final String value;

  const RemoveValueFromWorkspacePropertyInput({
    required this.id,
    required this.propertyName,
    required this.value,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'propertyName': propertyName,
        'value': value,
      };
}
