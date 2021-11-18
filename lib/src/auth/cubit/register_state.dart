part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final FormStatus status;
  final String username;
  final String email;
  final String password;
  final String repeatPassword;

  const RegisterState({
    this.status = FormStatus.none,
    this.username = '',
    this.email = '',
    this.password = '',
    this.repeatPassword = '',
  });

  RegisterState copyWith({
    FormStatus status = FormStatus.none,
    String? username,
    String? email,
    String? password,
    String? repeatPassword,
  }) =>
      RegisterState(
        status: status,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        repeatPassword: repeatPassword ?? this.repeatPassword,
      );

  @override
  List<Object?> get props =>
      [status, username, email, password, repeatPassword];
}
