import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/graphql.dart';
import 'package:task_helper/models/dto/token_response.dart';
import 'package:task_helper/models/dto/user_signup.dart';
import 'package:task_helper/models/token.dart';
import 'package:task_helper/sceens/auth/auth_card.dart';
import 'package:task_helper/token_storage.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final rpassword = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    rpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Mutation(
        options: MutationOptions(document: gql(registerMutation)),
        builder: (runMutation, result) {
          if (result?.hasException ?? false) {
            debugPrint(result!.exception.toString());
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to register'),
                  backgroundColor: Colors.red,
                ),
              ),
            );
          }

          if (result?.data != null) {
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) async {
                final tokens = TokenResponse.fromJson(result!.data!['signup']);

                await setAccessToken(Token(tokens.accessToken));
                await setRefreshToken(Token(tokens.refreshToken));

                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
            );
          }

          void submit() {
            if (!formKey.currentState!.validate()) return;

            runMutation({
              'signupInput': UserSignup(
                username.text.trim(),
                email.text.trim(),
                password.text.trim(),
              ).toMap()
            });
          }

          return Form(
            key: formKey,
            child: AuthCard(
              children: [
                Center(
                  child: Text(
                    'Register',
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
                  validator: (value) {
                    if (value == null) return null;
                    return usernameRegex.hasMatch(value.trim())
                        ? null
                        : 'Username invalid';
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: email,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: password,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  onFieldSubmitted: (_) => submit(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: rpassword,
                  decoration: const InputDecoration(
                    labelText: 'Repeat password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  validator: (value) {
                    if (value == null) return null;
                    return password.text.trim() != value.trim()
                        ? 'Passwords do not match'
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  obscureText: true,
                  onFieldSubmitted: (_) => submit(),
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
                    child: const Text('Register'),
                  ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () =>
                      DefaultTabController.of(context)!.animateTo(0),
                  child: const Text('Login here'),
                ),
              ],
            ),
          );
        },
      );
}

final usernameRegex = RegExp(r'^[a-zA-Z0-9_\-]{6,50}$');
final emailRegex = RegExp(r'[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+');
final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{10,40}$');
