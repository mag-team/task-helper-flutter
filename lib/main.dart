import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/graphql.dart';
import 'package:task_helper/models/token.dart';
import 'package:task_helper/sceens/auth/auth_screen.dart';
import 'package:task_helper/sceens/home/home_screen.dart';
import 'package:task_helper/token_storage.dart';

void main() => runApp(
      GraphQLProvider(
        client: gqlClient,
        child: const App(),
      ),
    );

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
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
      );
}
