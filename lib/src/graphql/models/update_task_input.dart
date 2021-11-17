class UpdateTaskInput {
  final String id;
  final String? title;
  final String? parentTask;

  const UpdateTaskInput({
    required this.id,
    this.title,
    this.parentTask,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        if (title != null) 'title': title,
        if (parentTask != null) 'parentTask': parentTask,
      };
}
