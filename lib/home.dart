import 'package:flutter/material.dart';
import 'package:fooderlich/screens/grocery_screen.dart';

import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    GroceryScreen(),
  ];

  void _onItemTapped(TabManager tabManager, int index) {
    tabManager.goToTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, _) {
        return Scaffold(
          body: pages[tabManager.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Grocery List',
              ),
            ],
            currentIndex: tabManager.selectedTab,
            onTap: (index) => _onItemTapped(tabManager, index),
          ),
        );
      },
    );
  }
}
