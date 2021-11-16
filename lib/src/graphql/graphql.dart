export 'models/models.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/models/token.dart';

GraphQLClient _getRefreshClient(AuthCubit authCubit, String gqlUrl) {
  final apiLink = HttpLink(gqlUrl);

  final AuthLink authLink = AuthLink(
    getToken: () async {
      final state = authCubit.state;
      if (state is! AuthSuccess || state.refreshToken.isExpired) return null;
      return 'Bearer ${state.refreshToken}';
    },
  );

  return GraphQLClient(
    link: authLink.concat(apiLink),
    cache: GraphQLCache(),
  );
}

GraphQLClient getGqlClient(AuthCubit authCubit, String gqlUrl) {
  final refreshClient = _getRefreshClient(authCubit, gqlUrl);

  final apiLink = HttpLink(gqlUrl);

  final AuthLink authLink = AuthLink(
    getToken: () async {
      final state = authCubit.state;
      if (state is! AuthSuccess) return null;

      if (state.accessToken?.isExpired == false) {
        return 'Bearer ${state.accessToken}';
      }

      // Cannot refresh refresh token
      if (state.refreshToken.isExpired) {
        await authCubit.logout();
        return null;
      }

      // Request new token
      final res = await refreshClient.mutate(MutationOptions(
        document: gql(refreshMutation),
      ));

      if (res.hasException) return null;

      final newToken = Token(res.data!['refreshAccessToken']['access_token']);
      authCubit.refreshToken(newToken);
      return 'Bearer $newToken';
    },
  );

  return GraphQLClient(
    link: authLink.concat(apiLink),
    cache: GraphQLCache(),
  );
}

const registerMutation = r'''
mutation Register($signupInput: SignupInput!) {
  signup(signupInput: $signupInput) {
    access_token,
    refresh_token
  }
}
''';

const loginMutation = r'''
mutation Login($loginInput: LoginInput!) {
  login(loginInput: $loginInput) {
    access_token,
    refresh_token
  }
}
''';

const refreshMutation = r'''
mutation Refresh {
  refreshAccessToken {
    access_token
  }
}
''';

const usersQuery = r'''
query GetUsers {
  users {
    id,
    username,
    email
  }
}
''';

const userQuery = r'''
query GetUser($id: ID!) {
  user(id: $id) {
    id,
    username,
    email
  }
}
''';
