class RemoveMemberInput {
  final String id;
  final String userId;

  const RemoveMemberInput({
    required this.id,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
      };
}
