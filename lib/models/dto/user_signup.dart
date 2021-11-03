class UserSignup {
  final String username;
  final String email;
  final String password;

  UserSignup(this.username, this.email, this.password);

  Map<String, dynamic> toMap() => {
        'username': username,
        'email': email,
        'password': password,
      };
}
