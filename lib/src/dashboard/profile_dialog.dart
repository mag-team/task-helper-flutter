import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/cubit/profile_cubit.dart';
import 'package:task_helper/src/task_repository.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, auth) => BlocProvider(
              create: (context) => ProfileCubit(
                context.read<TaskRepository>(),
                (auth as AuthSuccess).userId,
              ),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  final textTheme = Theme.of(context).textTheme;

                  if (state is ProfileError) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error),
                        Text(state.error, style: textTheme.subtitle1),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () => context.read<AuthCubit>().logout(),
                          child: const Text('Logout'),
                          style: TextButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is ProfileLoading) {
                    return const SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is ProfileLoaded) {
                    final user = state.user;

                    return SizedBox(
                      width: 400,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('My profile', style: textTheme.headline4),
                                const SizedBox(height: 15),
                                Text(user.username, style: textTheme.headline5),
                                Text(user.email, style: textTheme.subtitle1),
                                Text(user.id, style: textTheme.subtitle2),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<AuthCubit>().logout();
                              Navigator.pop(context);
                            },
                            tooltip: 'Logout',
                            icon: const Icon(Icons.logout, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );
}
