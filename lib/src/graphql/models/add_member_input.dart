class AddMemberInput {
  final String id;
  final String userId;

  const AddMemberInput({
    required this.id,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
      };
}
