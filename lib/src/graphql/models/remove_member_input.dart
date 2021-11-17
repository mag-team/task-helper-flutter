class RemoveMemberInput {
  final String id;
  final String userId;

  const RemoveMemberInput({
    required this.id,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
      };
}
