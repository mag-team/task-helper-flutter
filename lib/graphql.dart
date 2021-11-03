import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/models/token.dart';
import 'package:task_helper/token_storage.dart';

final HttpLink _apiLink = HttpLink('https://task.skippy-ai.xyz/graphql');

GraphQLClient _getRefreshClient() {
  final AuthLink authLink = AuthLink(
    getToken: () async {
      final token = await getRefreshToken();
      return token != null ? 'Bearer $token' : null;
    },
  );

  return GraphQLClient(
    link: _apiLink.concat(authLink),
    cache: GraphQLCache(),
  );
}

final _refreshClient = _getRefreshClient();
final gqlClient = _getGqlClient();

ValueNotifier<GraphQLClient> _getGqlClient() {
  final AuthLink authLink = AuthLink(
    getToken: () async {
      final token = await getAccessToken();
      if (token?.isExpired == false) return 'Bearer $token';

      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return null;

      if (refreshToken.isExpired) {
        await setRefreshToken(null);
        return null;
      }

      // Request new token
      final res = await _refreshClient.mutate(MutationOptions(
        document: gql(refreshMutation),
      ));

      if (res.hasException) return null;

      final newToken = Token(res.data!['refreshAccessToken']['access_token']);
      await setAccessToken(newToken);
      return 'Bearer $newToken';
    },
  );

  return ValueNotifier(
    GraphQLClient(
      link: _apiLink.concat(authLink),
      cache: GraphQLCache(),
    ),
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
