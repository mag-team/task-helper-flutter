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
  Widget build(BuildContext context) => Positioned.fill(
        bottom: MediaQuery.of(context).size.height * 0.55,
        child: Material(
          color: Theme.of(context).primaryColor,
          elevation: 10,
        ),
      );
}
