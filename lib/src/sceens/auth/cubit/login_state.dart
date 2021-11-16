part of 'login_cubit.dart';

enum LoginFormStatus { none, inProgress, failed, success }

class LoginState extends Equatable {
  final LoginFormStatus status;
  final String username;
  final String password;

  const LoginState({
    this.status = LoginFormStatus.none,
    this.username = '',
    this.password = '',
  });

  LoginState copyWith({
    LoginFormStatus? status,
    String? username,
    String? password,
  }) =>
      LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [status, username, password];
}
