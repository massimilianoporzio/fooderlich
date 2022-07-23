import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fooderlich/models/models.dart';

import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'home.dart';
import 'models/tab_manager.dart';

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
      locale: const Locale('it', 'IT'),
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
        const Locale('it', 'IT'),
      ],
      scrollBehavior: MyCustomScrollBehavior(),
      theme: theme,
      title: 'Fooderlich',
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => TabManager()),
        ChangeNotifierProvider(create: (context) => GroceryManager()),
      ], child: const Home()),
    );
  }
}
