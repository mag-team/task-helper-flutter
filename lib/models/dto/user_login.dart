class UserLogin {
  final String username;
  final String password;

  const UserLogin(this.username, this.password);

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
      };
}
