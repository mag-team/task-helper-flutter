class UpdateUserInput {
  final String? username;
  final String? email;

  const UpdateUserInput({
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        if (username != null) 'username': username,
        if (email != null) 'email': email,
      };
}
