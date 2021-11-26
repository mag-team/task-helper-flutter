class WorkspacePropertyInput {
  final String name;
  final String type;
  final List<String> values;

  const WorkspacePropertyInput({
    required this.name,
    required this.type,
    required this.values,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'values': values,
      };
}
