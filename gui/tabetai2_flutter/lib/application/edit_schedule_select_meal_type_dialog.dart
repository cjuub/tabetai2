import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/edit_schedule_select_recipe_meal_widget.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleSelectMealTypeDialog extends StatelessWidget {
  final int index;
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;

  const EditScheduleSelectMealTypeDialog(
      {Key? key, required this.index, required this.mealsData, required this.recipesData})
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
          onTap: () {},
        ),
        InkWell(
          child: const Text("Leftovers", textScaleFactor: 2.0, textAlign: TextAlign.center),
          onTap: () {},
        ),
        InkWell(
          child: const Text("Other", textScaleFactor: 2.0, textAlign: TextAlign.center),
          onTap: () {},
        ),
      ],
    );
  }
}
