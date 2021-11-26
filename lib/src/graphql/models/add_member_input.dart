class AddMemberInput {
  final String id;
  final String userId;

  const AddMemberInput({
    required this.id,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
      };
}
