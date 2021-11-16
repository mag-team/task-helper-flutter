import 'package:flutter/material.dart';

import 'profile_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const TopBar(),
            Expanded(
              child: Row(
                children: const [
                  SideBar(),
                ],
              ),
            ),
          ],
        ),
      );
}

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 55,
      child: Material(
        elevation: 0,
        color: theme.primaryColor,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                type: MaterialType.button,
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade800,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Center(
                    child: Text(
                      'M',
                      style: theme.textTheme.subtitle1!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        elevation: 6,
        color: Colors.blue.shade800,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Expanded(child: SizedBox.shrink()),
              Text(
                'Task Helper',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    type: MaterialType.button,
                    borderRadius: BorderRadius.circular(50),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.blue,
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => const ProfileDialog(),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
