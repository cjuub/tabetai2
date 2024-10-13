import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleSelectLeftoversMealDialog extends StatefulWidget {
  final int index;
  final List<MealData> mealsData;
  final List<ScheduleDayData> scheduleDaysData;

  const EditScheduleSelectLeftoversMealDialog(
      {required this.index, required this.mealsData, required this.scheduleDaysData, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleSelectLeftoversMealDialogState();
}

class _EditScheduleSelectLeftoversMealDialogState extends State<EditScheduleSelectLeftoversMealDialog> {
  String _title = "";
  int _servings = 4;
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    Set<String> mealTitlesInScheduleSet = {};
    for (ScheduleDayData dayData in widget.scheduleDaysData) {
      mealTitlesInScheduleSet.addAll(dayData.meals.map((meal) => meal.title));
    }
    List<String> mealTitlesInSchedule = mealTitlesInScheduleSet.toList();

    return SimpleDialog(
      title: const Text("Enter Leftovers Meal", textAlign: TextAlign.center),
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
            hintText: 'Enter title manually',
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
            widget.mealsData[widget.index] = LeftoversMealData(_title, _servings, _comment);
            Navigator.pop(context);
          },
          child: const Text("Confirm", textScaleFactor: 3.0),
        ),
        const Divider(),
        SizedBox(
          width: double.minPositive + 1000,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: mealTitlesInSchedule.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Text(mealTitlesInSchedule[index], textScaleFactor: 2.0, textAlign: TextAlign.center),
                    onTap: () {
                      setState(
                        () {
                          widget.mealsData[widget.index] =
                              LeftoversMealData(mealTitlesInSchedule[index], _servings, _comment);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
