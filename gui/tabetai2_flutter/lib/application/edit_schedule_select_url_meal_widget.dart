import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleSelectUrlMealDialog extends StatefulWidget {
  final int index;
  final List<MealData> mealsData;

  const EditScheduleSelectUrlMealDialog({required this.index, required this.mealsData, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleSelectUrlMealDialogState();
}

class _EditScheduleSelectUrlMealDialogState extends State<EditScheduleSelectUrlMealDialog> {
  String _title = "";
  int _servings = 4;
  String _comment = "";
  String _url = "";

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Enter Recipe URL", textAlign: TextAlign.center),
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
            hintText: 'Enter recipe title...',
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
            hintText: 'Enter URL...',
          ),
          onChanged: (text) {
            setState(() {
              _url = text;
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
              widget.mealsData[widget.index] = ExternalRecipeMealData(_title, _servings, _comment, _url);
              Navigator.pop(context);
            },
            child: const Text("Confirm", textScaleFactor: 3.0)),
      ],
    );
  }
}
