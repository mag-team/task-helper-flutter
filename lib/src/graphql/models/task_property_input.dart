class TaskPropertyInput {
  final String name;
  final String? value;

  const TaskPropertyInput({
    required this.name,
    this.value,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        if (value != null) 'value': value,
      };
}
