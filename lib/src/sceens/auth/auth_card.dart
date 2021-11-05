import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final List<Widget> children;

  const AuthCard({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(25),
                children: children,
              ),
            ),
          ),
        ),
      );
}
