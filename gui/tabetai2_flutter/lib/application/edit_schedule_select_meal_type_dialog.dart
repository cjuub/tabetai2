import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/edit_schedule_select_leftovers_meal_widget.dart';
import 'package:tabetai2_flutter/application/edit_schedule_select_other_meal_widget.dart';
import 'package:tabetai2_flutter/application/edit_schedule_select_recipe_meal_widget.dart';
import 'package:tabetai2_flutter/application/edit_schedule_select_url_meal_widget.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleSelectMealTypeDialog extends StatelessWidget {
  final int index;
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;
  final List<ScheduleDayData> scheduleDaysData;

  const EditScheduleSelectMealTypeDialog(
      {Key? key,
      required this.index,
      required this.mealsData,
      required this.recipesData,
      required this.scheduleDaysData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Select Meal Type", textAlign: TextAlign.center),
      children: [
        InkWell(
          child: const Text("From Recipe", textScaleFactor: 2.0, textAlign: TextAlign.center),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditScheduleSelectRecipeMealDialog(index: index, mealsData: mealsData, recipesData: recipesData);
              },
            ).then(
              (value) => {Navigator.pop(context)},
            );
          },
        ),
        InkWell(
          child: const Text("From URL", textScaleFactor: 2.0, textAlign: TextAlign.center),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditScheduleSelectUrlMealDialog(index: index, mealsData: mealsData);
              },
            ).then(
              (value) => {Navigator.pop(context)},
            );
          },
        ),
        InkWell(
          child: const Text("Leftovers", textScaleFactor: 2.0, textAlign: TextAlign.center),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditScheduleSelectLeftoversMealDialog(
                    index: index, mealsData: mealsData, scheduleDaysData: scheduleDaysData);
              },
            ).then(
              (value) => {Navigator.pop(context)},
            );
          },
        ),
        InkWell(
          child: const Text("Other", textScaleFactor: 2.0, textAlign: TextAlign.center),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditScheduleSelectOtherMealDialog(index: index, mealsData: mealsData);
              },
            ).then(
              (value) => {Navigator.pop(context)},
            );
          },
        ),
      ],
    );
  }
}
