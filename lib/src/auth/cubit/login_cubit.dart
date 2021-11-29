import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/models/form_status.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/models/token.dart';
import 'package:task_helper/src/task_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TaskRepository taskRepository;
  final AuthCubit authCubit;

  LoginCubit({
    required this.taskRepository,
    required this.authCubit,
  }) : super(const LoginState());

  void setUsername(String value) {
    emit(state.copyWith(username: value));
  }

  void setPassword(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: FormStatus.inProgress));

    try {
      final tokens = await taskRepository.login(LoginInput(
        username: state.username,
        password: state.password,
      ));

      emit(state.copyWith(status: FormStatus.success));
      authCubit.login(Token(tokens.refreshToken), Token(tokens.accessToken));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormStatus.failed));
    }
  }
}
