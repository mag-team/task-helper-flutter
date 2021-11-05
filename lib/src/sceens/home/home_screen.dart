import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_helper/src/graphql/graphql.dart';
import 'package:task_helper/src/models/user.dart';
import 'package:task_helper/src/token_storage.dart';

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
                        builder: (_) => const Profile(),
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

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Query(
            options: QueryOptions(
              document: gql(userQuery),
              variables: {'id': userId},
            ),
            builder: (result, {fetchMore, refetch}) {
              final textTheme = Theme.of(context).textTheme;

              if (result.hasException) {
                debugPrint(result.exception?.toString());

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error),
                    Text(
                      'Something went wrong',
                      style: textTheme.subtitle1,
                    ),
                  ],
                );
              }

              if (result.isLoading) {
                return const SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final user = User.fromMap(result.data!['user']);

              return SizedBox(
                width: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My profile', style: textTheme.headline4),
                          const SizedBox(height: 15),
                          Text(user.username, style: textTheme.headline5),
                          Text(user.email, style: textTheme.subtitle1),
                          Text(user.id, style: textTheme.subtitle2),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      tooltip: 'Logout',
                      icon: const Icon(Icons.logout, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
