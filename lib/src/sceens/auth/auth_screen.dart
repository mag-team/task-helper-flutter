import 'package:flutter/material.dart';

import 'login_form.dart';
import 'register_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Stack(
            fit: StackFit.expand,
            children: const [
              _Background(),
              TabBarView(
                children: [
                  LoginForm(),
                  RegisterForm(),
                ],
              ),
            ],
          ),
        ),
      );
}

class _Background extends StatelessWidget {
  const _Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned.fill(
      bottom: MediaQuery.of(context).size.height * 0.55,
      child: Material(
        color: theme.primaryColor,
        elevation: 10,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Text(
              'Task helper',
              style: theme.textTheme.headline3
                  ?.copyWith(color: const Color(0xeeffffff)),
            ),
          ),
        ),
      ),
    );
  }
}
