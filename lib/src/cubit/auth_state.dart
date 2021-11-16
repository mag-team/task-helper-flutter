part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthSuccess extends AuthState {
  final Token? accessToken;
  final Token refreshToken;

  String get userId => refreshToken.userId;

  const AuthSuccess({
    required this.accessToken,
    required this.refreshToken,
  });

  AuthSuccess copyWith({
    required Token? accessToken,
    Token? refreshToken,
  }) =>
      AuthSuccess(
        accessToken: accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  @override
  List<Object?> get props => [accessToken?.token, refreshToken.token];
}
