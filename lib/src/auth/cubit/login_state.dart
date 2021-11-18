part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FormStatus status;
  final String username;
  final String password;

  const LoginState({
    this.status = FormStatus.none,
    this.username = '',
    this.password = '',
  });

  LoginState copyWith({
    FormStatus status = FormStatus.none,
    String? username,
    String? password,
  }) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [status, username, password];
}
