import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'models/token.dart';
import 'sceens/auth/auth_screen.dart';
import 'sceens/home/home_screen.dart';
import 'token_storage.dart';

class App extends StatelessWidget {
  final ValueNotifier<GraphQLClient> graphQlClient;

  const App({
    Key? key,
    required this.graphQlClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GraphQLProvider(
        client: graphQlClient,
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
          onGenerateRoute: (_) {
            final w = FutureBuilder<Token?>(
              future: getRefreshToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data?.isExpired == false) {
                    return const HomeScreen();
                  } else {
                    return const AuthScreen();
                  }
                }

                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );

            return MaterialPageRoute(builder: (_) => w);
          },
        ),
      );
}
