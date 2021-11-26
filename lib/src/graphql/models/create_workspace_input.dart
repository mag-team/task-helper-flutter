class CreateWorkspaceInput {
  final String title;
  final String? description;

  const CreateWorkspaceInput({
    required this.title,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        if (description != null) 'description': description,
      };
}
