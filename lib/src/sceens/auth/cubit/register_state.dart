part of 'register_cubit.dart';

enum RegisterFormStatus { none, inProgress, failed, success }

class RegisterState extends Equatable {
  final RegisterFormStatus status;
  final String username;
  final String email;
  final String password;
  final String repeatPassword;

  const RegisterState({
    this.status = RegisterFormStatus.none,
    this.username = '',
    this.email = '',
    this.password = '',
    this.repeatPassword = '',
  });

  RegisterState copyWith({
    RegisterFormStatus? status,
    String? username,
    String? email,
    String? password,
    String? repeatPassword,
  }) =>
      RegisterState(
        status: status ?? this.status,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        repeatPassword: repeatPassword ?? this.repeatPassword,
      );

  @override
  List<Object?> get props =>
      [status, username, email, password, repeatPassword];
}
