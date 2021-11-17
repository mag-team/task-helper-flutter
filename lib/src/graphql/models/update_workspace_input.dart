class UpdateWorkspaceInput {
  final String id;
  final String? title;

  const UpdateWorkspaceInput({
    required this.id,
    this.title,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        if (title != null) 'title': title,
      };
}
