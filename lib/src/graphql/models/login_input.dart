class LoginInput {
  final String username;
  final String password;

  const LoginInput({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
