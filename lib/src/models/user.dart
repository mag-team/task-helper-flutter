import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;

  const User({
    required this.id,
    required this.username,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        email = map['email'];

  @override
  List<Object?> get props => [id, username, email];
}
