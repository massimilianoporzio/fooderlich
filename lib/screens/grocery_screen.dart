import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/screens/empty_grocery_screen.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //TODO 11
          print("ADD ITEM");
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer(builder: (context, GroceryManager manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        //TODO 25
        return Container(
          color: Colors.amber,
        );
      } else {
        return EmptyGroceryScreen();
      }
    });
  }
}
