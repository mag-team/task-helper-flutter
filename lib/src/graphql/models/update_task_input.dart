class UpdateTaskInput {
  final String id;
  final String? title;
  final String? parentTask;

  const UpdateTaskInput({
    required this.id,
    this.title,
    this.parentTask,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        if (title != null) 'title': title,
        if (parentTask != null) 'parentTask': parentTask,
      };
}
