import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/edit_schedule_select_meal_type_dialog.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleMealsListEntryWidget extends StatefulWidget {
  final int index;
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;
  final List<ScheduleDayData> scheduleDaysData;
  final List<String> units;
  final BackendClient backendClient;

  const EditScheduleMealsListEntryWidget(
      {required this.index,
      required this.mealsData,
      required this.recipesData,
      required this.scheduleDaysData,
      required this.units,
      required this.backendClient,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleMealsListEntryWidgetState();
}

class _EditScheduleMealsListEntryWidgetState extends State<EditScheduleMealsListEntryWidget> {
  @override
  Widget build(BuildContext context) {
    MealData mealData = widget.mealsData[widget.index];

    List<Widget> columnEntries = [
      Text(mealData.title, textScaleFactor: 2.0),
    ];

    Color color = Colors.white;
    if (mealData is ExternalRecipeMealData) {
      columnEntries.add(Text("URL: ${mealData.url}", textScaleFactor: 1.0));
      color = Colors.orange[100]!;
    } else if (mealData is RecipeMealData) {
      color = Colors.teal[100]!;
    } else if (mealData is LeftoversMealData) {
      color = Colors.lime[100]!;
    } else if (mealData is OtherMealData) {
      color = Colors.red[100]!;
    }

    columnEntries.addAll(
      [
        const Padding(padding: EdgeInsets.only(top: 15)),
        Text("Servings: ${mealData.servings}", textScaleFactor: 1.0),
        Text("Comment: ${mealData.comment}", textScaleFactor: 1.0),
        const Padding(padding: EdgeInsets.only(top: 15)),
      ],
    );

    return Material(
      color: color,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditScheduleSelectMealTypeDialog(
                index: widget.index,
                mealsData: widget.mealsData,
                recipesData: widget.recipesData,
                scheduleDaysData: widget.scheduleDaysData,
              );
            },
          ).then(
            (value) => setState(
              () {
                mealData = widget.mealsData[widget.index];
              },
            ),
          );
        },
        child: Column(
          children: columnEntries,
        ),
      ),
    );
  }
}
