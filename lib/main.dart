import 'package:flutter/material.dart';
import 'package:task_helper/src/graphql/graphql.dart';

import 'src/app.dart';

void main() {
  final gqlClient = getGqlClient();

  runApp(App(graphQlClient: gqlClient));
}
