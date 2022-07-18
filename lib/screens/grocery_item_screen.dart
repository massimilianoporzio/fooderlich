import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:fooderlich/models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? oringinalItem;
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.oringinalItem,
  })  : isUpdating = (oringinalItem != null),
        super(key: key);

  @override
  State<GroceryItemScreen> createState() {
    return _GroceryItemScreenState();
  }
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO 12: Add GroceryItemScreen Scaffold
    return Container(color: Colors.orange);
  }

  // TODO: Add buildNameField()
  // TODO: Add buildImportanceField()
  // TODO: ADD buildDateField()
  // TODO: Add buildTimeField()
  // TODO: Add buildColorPicker()
  // TODO: Add buildQuantityField()

}