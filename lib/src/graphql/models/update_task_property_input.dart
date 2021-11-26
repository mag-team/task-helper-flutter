import 'task_property_input.dart';

class UpdateTaskPropertyInput {
  final String id;
  final TaskPropertyInput property;

  const UpdateTaskPropertyInput({
    required this.id,
    required this.property,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'property': property,
      };
}
