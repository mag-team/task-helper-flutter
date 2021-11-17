import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/models/token.dart';
import 'package:task_helper/src/task_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TaskRepository taskRepository;
  final AuthCubit authCubit;

  RegisterCubit({
    required this.taskRepository,
    required this.authCubit,
  }) : super(const RegisterState());

  void setUsername(String value) {
    emit(state.copyWith(
      status: RegisterFormStatus.none,
      username: value,
    ));
  }

  void setEmail(String value) {
    emit(state.copyWith(
      status: RegisterFormStatus.none,
      email: value,
    ));
  }

  void setPassword(String value) {
    emit(state.copyWith(
      status: RegisterFormStatus.none,
      password: value,
    ));
  }

  void setRepeatPassword(String value) {
    emit(state.copyWith(
      status: RegisterFormStatus.none,
      repeatPassword: value,
    ));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: RegisterFormStatus.inProgress));

    try {
      final tokens = await taskRepository.register(SignupInput(
        username: state.username.trim(),
        email: state.email.trim(),
        password: state.password.trim(),
      ));

      emit(state.copyWith(status: RegisterFormStatus.success));
      authCubit.login(Token(tokens.refreshToken), Token(tokens.accessToken));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: RegisterFormStatus.failed));
    }
  }
}
