class User {
  final String id;
  final String username;
  final String email;

  const User(this.id, this.username, this.email);

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        email = map['email'];
}
