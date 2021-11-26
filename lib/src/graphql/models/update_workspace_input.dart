class UpdateWorkspaceInput {
  final String id;
  final String? title;
  final String? description;

  const UpdateWorkspaceInput({
    required this.id,
    this.title,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        if (title != null) 'title': title,
        if (description != null) 'description': description,
      };
}
