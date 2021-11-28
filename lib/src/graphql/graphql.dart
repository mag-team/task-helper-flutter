export 'models/models.dart';
export 'documents.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/src/cubit/auth_cubit.dart';
import 'package:task_helper/src/models/token.dart';

import 'documents.dart';

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

      if (res.hasException) {
        if (res.exception!.graphqlErrors.isNotEmpty) authCubit.logout();
        return null;
      }

      final newToken = Token(res.data!['refreshAccessToken']['access_token']);
      authCubit.refreshToken(newToken);
      return 'Bearer $newToken';
    },
  );

  // Cache issue https://github.com/zino-app/graphql-flutter/issues/788
  final policies = Policies(
    fetch: FetchPolicy.noCache,
  );

  return GraphQLClient(
    link: authLink.concat(apiLink),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      watchQuery: policies,
      query: policies,
      mutate: policies,
    ),
  );
}
