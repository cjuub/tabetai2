import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/edit_schedule_meals_list_entry_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleMealsListWidget extends StatefulWidget {
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;
  final List<String> units;
  final BackendClient backendClient;

  const EditScheduleMealsListWidget(
      {required this.mealsData, required this.recipesData, required this.units, required this.backendClient, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleMealsListWidgetState();
}

class _EditScheduleMealsListWidgetState extends State<EditScheduleMealsListWidget> {
  late final String defaultRecipeId;
  late final String defaultRecipeName;

  @override
  void initState() {
    super.initState();

    defaultRecipeName = widget.recipesData[0].name;
    defaultRecipeId = widget.recipesData[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.mealsData.length,
              itemBuilder: (BuildContext context, int index) {
                return EditScheduleMealsListEntryWidget(
                    index: index,
                    mealsData: widget.mealsData,
                    recipesData: widget.recipesData,
                    units: widget.units,
                    backendClient: widget.backendClient);
              }),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
                onPressed: () => {
                      setState(() {
                        widget.mealsData.removeLast();
                      })
                    },
                child: const Text("-", textScaleFactor: 3.0)),
            TextButton(
                onPressed: () => {
                      setState(() {
                        widget.mealsData.add(RecipeMealData(defaultRecipeName, 4, "", defaultRecipeId));
                      })
                    },
                child: const Text("+", textScaleFactor: 3.0)),
          ])
        ]));
  }
}
