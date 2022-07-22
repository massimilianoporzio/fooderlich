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
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    // TODO 12: Add GroceryItemScreen Scaffold
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //TODO 24 add callback
              },
              icon: Icon(Icons.check))
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.adamina(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            // TODO 15: Add date picker
            // TODO 16: Add time picker
            // TODO 17: Add color picker
            // TODO 18: Add slider
            // TODO: 19: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    //STATOini INIZIALE: SE originalItem non è null mostro i suo valori
    final originalItem = widget.oringinalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _importance = originalItem.importance;
      final date = originalItem.date;
      _dueDate = date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _currentColor = originalItem.color;
      _currentSliderValue = originalItem.quantity;
    }
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: 'E.g. Apples, Bananas, 1 Bag of salt',
          ),
        ),
      ],
    );
  }

  // TODO: Add buildImportanceField()
  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
          child: Text(
            'Importance',
            style: GoogleFonts.lato(fontSize: 28.0),
          ),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'Low',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.low,
              onSelected: (selected) {
                setState(() {
                  _importance = selected ? Importance.low : Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'Medium',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = selected ? Importance.medium : Importance.low;
                });
              },
              selected: _importance == Importance.medium,
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'High',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = selected ? Importance.high : Importance.low;
                });
              },
              selected: _importance == Importance.high,
            ),
          ],
        ),
      ],
    );
  }
  // TODO: ADD buildDateField()
  // TODO: Add buildTimeField()
  // TODO: Add buildColorPicker()
  // TODO: Add buildQuantityField()

}
