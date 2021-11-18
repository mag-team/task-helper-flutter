import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/cubit/workspaces_cubit.dart';
import 'package:task_helper/src/task_repository.dart';

import 'auth/auth_screen.dart';
import 'dashboard/dashboard_screen.dart';

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
              scaffoldBackgroundColor: Color.alphaBlend(
                  Colors.blue.withAlpha(15), Colors.grey.shade200),
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
                  return BlocProvider(
                    create: (context) => WorkspacesCubit(
                      context.read<TaskRepository>(),
                    ),
                    child: const DashboardScreen(),
                  );
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
