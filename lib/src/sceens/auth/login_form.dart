import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/models/token.dart';
import 'package:task_helper/src/token_storage.dart';

import 'auth_card.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Mutation(
        options: MutationOptions(document: gql(loginMutation)),
        builder: (runMutation, result) {
          if (result?.hasException ?? false) {
            debugPrint(result!.exception.toString());
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to login'),
                  backgroundColor: Colors.red,
                ),
              ),
            );
          }

          if (result?.data != null) {
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) async {
                final tokens = Tokens.fromJson(result!.data!['login']);

                await setAccessToken(Token(tokens.accessToken));
                await setRefreshToken(Token(tokens.refreshToken));

                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
            );
          }

          void submit() => runMutation({
                'loginInput': LoginInput(
                  username: username.text.trim(),
                  password: password.text.trim(),
                ).toMap()
              });

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
                controller: username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                onFieldSubmitted: (_) {
                  if (username.text.isNotEmpty && password.text.isNotEmpty) {
                    submit();
                  }
                },
                autofocus: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
                obscureText: true,
                onFieldSubmitted: (_) {
                  if (username.text.isNotEmpty && password.text.isNotEmpty) {
                    submit();
                  }
                },
              ),
              const SizedBox(height: 15),
              if (result?.isLoading == true)
                const Center(child: CircularProgressIndicator())
              else if (result?.data != null)
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
                onPressed: () => DefaultTabController.of(context)!.animateTo(1),
                child: const Text('Register here'),
              ),
            ],
          );
        },
      );
}
