import 'dart:ui';

import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';
import 'home.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: theme,
      title: 'Fooderlich',
      // TODO 8: Replace this with MultiProvider
      home: const Home(),
    );
  }
}
