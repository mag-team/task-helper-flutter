class CreateWorkspaceInput {
  final String title;

  const CreateWorkspaceInput({required this.title});

  Map<String, dynamic> toMap() => {'title': title};
}
