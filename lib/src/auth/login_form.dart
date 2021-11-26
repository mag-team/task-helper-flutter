import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/form_status.dart';
import 'package:task_helper/src/task_repository.dart';

import 'auth_card.dart';
import 'cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => LoginCubit(
          taskRepository: context.read<TaskRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == FormStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to login'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            void submit() => context.read<LoginCubit>().submit();

            return AuthCard(
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: state.username,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) =>
                      context.read<LoginCubit>().setUsername(value),
                  onFieldSubmitted: (_) {
                    if (state.username.trim().isNotEmpty &&
                        state.password.trim().isNotEmpty) {
                      submit();
                    }
                  },
                  autofocus: true,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                  onChanged: (value) =>
                      context.read<LoginCubit>().setPassword(value),
                  onFieldSubmitted: (_) {
                    if (state.username.trim().isNotEmpty &&
                        state.password.trim().isNotEmpty) {
                      submit();
                    }
                  },
                ),
                const SizedBox(height: 15),
                if (state.status == FormStatus.inProgress)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == FormStatus.success)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  )
                else
                  ElevatedButton(
                    onPressed: () => submit(),
                    child: const Text('Login'),
                  ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () =>
                      DefaultTabController.of(context)!.animateTo(1),
                  child: const Text('Register here'),
                ),
              ],
            );
          },
        ),
      );
}
