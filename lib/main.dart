import 'package:flutter/material.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/task_repository.dart';

import 'src/app.dart';

void main() {
  final authCubit = AuthCubit();

  const gqlUrl = 'https://task.skippy-ai.xyz/graphql';
  final gqlClient = getGqlClient(authCubit, gqlUrl);
  final taskRepository = TaskRepository(graphQLClient: gqlClient);

  runApp(App(
    taskRepository: taskRepository,
    authCubit: authCubit,
  ));
}
