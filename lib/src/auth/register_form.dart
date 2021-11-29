import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/models/form_status.dart';
import 'package:task_helper/src/task_repository.dart';

import 'auth_card.dart';
import 'cubit/register_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => RegisterCubit(
          taskRepository: context.read<TaskRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == FormStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to register'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            void submit() {
              if (state.status == FormStatus.inProgress ||
                  !usernameRegex.hasMatch(state.username) ||
                  !emailRegex.hasMatch(state.email) ||
                  !passwordRegex.hasMatch(state.password) ||
                  state.password != state.repeatPassword) return;

              context.read<RegisterCubit>().submit();
            }

            return AuthCard(
              children: [
                Center(
                  child: Text(
                    'Register',
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
                  validator: (value) {
                    if (value == null) return null;
                    return usernameRegex.hasMatch(value.trim())
                        ? null
                        : 'Username invalid';
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  onChanged: (value) =>
                      context.read<RegisterCubit>().setUsername(value),
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value == null) return null;
                    return emailRegex.hasMatch(value.trim())
                        ? null
                        : 'Email invalid';
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) =>
                      context.read<RegisterCubit>().setEmail(value),
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  validator: (value) {
                    if (value == null) return null;
                    return passwordRegex.hasMatch(value.trim())
                        ? null
                        : 'Password invalid';
                  },
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  onChanged: (value) =>
                      context.read<RegisterCubit>().setPassword(value),
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.repeatPassword,
                  decoration: const InputDecoration(
                    labelText: 'Repeat password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  validator: (value) {
                    if (value == null) return null;
                    return state.password.trim() != value.trim()
                        ? 'Passwords do not match'
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  obscureText: true,
                  onChanged: (value) =>
                      context.read<RegisterCubit>().setRepeatPassword(value),
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 15),
                if (state.status == FormStatus.inProgress)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: () => context.read<RegisterCubit>().submit(),
                    child: const Text('Register'),
                  ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () =>
                      DefaultTabController.of(context)!.animateTo(0),
                  child: const Text('Login here'),
                ),
              ],
            );
          },
        ),
      );
}

final usernameRegex = RegExp(r'^[a-zA-Z0-9_\-]{6,50}$');
final emailRegex = RegExp(r'[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+');
final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{10,40}$');
