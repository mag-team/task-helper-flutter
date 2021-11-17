class CreateTaskInput {
  final String title;
  final String workspace;
  final String? parentTask;

  const CreateTaskInput({
    required this.title,
    required this.workspace,
    this.parentTask,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'workspace': workspace,
        if (parentTask != null) 'parentTask': parentTask,
      };
}
