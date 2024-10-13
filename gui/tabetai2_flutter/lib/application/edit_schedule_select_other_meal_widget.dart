import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleSelectOtherMealDialog extends StatefulWidget {
  final int index;
  final List<MealData> mealsData;

  const EditScheduleSelectOtherMealDialog({required this.index, required this.mealsData, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleSelectOtherMealDialogState();
}

class _EditScheduleSelectOtherMealDialogState extends State<EditScheduleSelectOtherMealDialog> {
  String _title = "";
  int _servings = 4;
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Enter Other Meal", textAlign: TextAlign.center),
      children: [
        Slider(
          value: _servings.toDouble(),
          divisions: 7,
          min: 1,
          max: 8,
          label: _servings.toString(),
          onChanged: (double value) {
            setState(() {
              _servings = value.round();
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter title...',
          ),
          onChanged: (text) {
            setState(() {
              _title = text;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter comment...',
          ),
          onChanged: (text) {
            setState(() {
              _comment = text;
            });
          },
        ),
        TextButton(
            onPressed: () {
              widget.mealsData[widget.index] = OtherMealData(_title, _servings, _comment);
              Navigator.pop(context);
            },
            child: const Text("Confirm", textScaleFactor: 3.0)),
      ],
    );
  }
}
