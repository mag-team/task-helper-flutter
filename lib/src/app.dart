import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/task_repository.dart';

import 'sceens/auth/auth_screen.dart';
import 'sceens/home/home_screen.dart';

class App extends StatelessWidget {
  final TaskRepository taskRepository;
  final AuthCubit authCubit;

  const App({
    Key? key,
    required this.taskRepository,
    required this.authCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: taskRepository,
        child: BlocProvider.value(
          value: authCubit,
          child: MaterialApp(
            title: 'Task Helper',
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
            ),
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial) return const AuthScreen();

                if (state is AuthSuccess && !state.refreshToken.isExpired) {
                  return const HomeScreen();
                }

                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      );
}
