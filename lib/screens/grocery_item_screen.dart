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
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10.0),
            buildColorPicker(context),
            const SizedBox(height: 10.0),
            buildQuantityField(),

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

  Widget buildImportanceField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
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
            runSpacing: 30.0,
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
      ),
    );
  }

  Widget buildDateField(BuildContext context) {
// 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
// 2
        Row(
// 3
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
// 4
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
// 5
            TextButton(
              child: const Text('Select'),
// 6
              onPressed: () async {
                final currentDate = DateTime.now();
// 7
                final selectedDate = await showDatePicker(
                  locale: const Locale('it', 'IT'),
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
// 8
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
// 9
        Text('${DateFormat('dd/MM/yyyy').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time of Day',
                style: GoogleFonts.lato(fontSize: 28.0),
              ),
              TextButton(
                child: const Text('Select'),
                onPressed: () async {
// 1
                  final timeOfDay = await showTimePicker(
// 2
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
// 3
                  setState(() {
                    if (timeOfDay != null) {
                      _timeOfDay = timeOfDay;
                    }
                  });
                },
              ),
            ],
          ),
          Text('${_timeOfDay.format(context)}'),
        ],
      ),
    );
  }

  Widget buildColorPicker(BuildContext context) {
// 1
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
// 2
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
// 3
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
// 5
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
// 6
                    onColorChanged: (color) {
                      setState(() => _currentColor = color);
                    },
                  ),
                  actions: [
// 7
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('Quantity', style: GoogleFonts.lato(fontSize: 28.0)),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
            inactiveColor: _currentColor.withOpacity(0.5),
            value: _currentSliderValue.toDouble(),
            min: 0.0,
            max: 100.0,
            divisions: 100,
            label: _currentSliderValue.toInt().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value.toInt();
              });
            }),
      ]),
    );
  }
}
