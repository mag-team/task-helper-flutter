import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/models/task.dart';
import 'package:task_helper/src/models/user.dart';
import 'package:task_helper/src/models/workspace.dart';

class TaskRepository {
  final GraphQLClient graphQLClient;

  TaskRepository({required this.graphQLClient});

  Future<Tokens> register(SignupInput signupInput) async {
    final opt = MutationOptions(
      document: gql(registerMutation),
      variables: {'signupInput': signupInput.toJson()},
    );

    final res = await graphQLClient.mutate(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return Tokens.fromJson(res.data!['signup']);
  }

  Future<Tokens> login(LoginInput loginInput) async {
    final opt = MutationOptions(
      document: gql(loginMutation),
      variables: {'loginInput': loginInput.toJson()},
    );

    final res = await graphQLClient.mutate(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return Tokens.fromJson(res.data!['login']);
  }

  Future<User> getUserById(String id) async {
    final opt = QueryOptions(
      document: gql(userQuery),
      variables: {'id': id},
    );

    final res = await graphQLClient.query(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return User.fromJson(res.data!['user']);
  }

  Future<Workspace> createWorkspace(CreateWorkspaceInput input) async {
    final opt = MutationOptions(
      document: gql(createWorkspaceMutation),
      variables: {'createWorkspaceInput': input.toJson()},
    );

    final res = await graphQLClient.mutate(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return Workspace.fromJson(res.data!['createWorkspace']);
  }

  Future<List<Workspace>> getWorkspaces() async {
    final opt = QueryOptions(document: gql(workspacesQuery));

    final res = await graphQLClient.query(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return (res.data!['workspaces'] as List)
        .map((e) => Workspace.fromJson(e))
        .toList();
  }

  Future<Workspace> getWorkspaceById(String id) async {
    final opt = QueryOptions(
      document: gql(workspaceQuery),
      variables: {'id': id},
    );

    final res = await graphQLClient.query(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return Workspace.fromJson(res.data!['workspace']);
  }

  Future<Task> createTask(CreateTaskInput createTaskInput) async {
    final opt = MutationOptions(
      document: gql(createTaskMutation),
      variables: {'createTaskInput': createTaskInput.toJson()},
    );

    final res = await graphQLClient.mutate(opt);

    if (res.hasException) throw Exception(res.exception!.toString());

    return Task.fromJson(res.data!['createTask']);
  }
}
