import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/recipe_view.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class ScheduleMealsListWidget extends StatefulWidget {
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;
  final List<IngredientData> ingredientsData;
  final List<String> units;
  final BackendClient backendClient;

  ScheduleMealsListWidget(
      {required this.mealsData,
      required this.recipesData,
      required this.ingredientsData,
      required this.units,
      required this.backendClient,
      Key? key})
      : super(key: key) {}

  @override
  State<StatefulWidget> createState() => _ScheduleMealsListWidgetState();
}

class _ScheduleMealsListWidgetState extends State<ScheduleMealsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.mealsData.length,
            itemBuilder: (BuildContext context, int index) {
              String mealRecipeId = widget.mealsData[index].recipeId;
              RecipeData mealRecipeData = widget.recipesData
                  .firstWhere((recipeData) => recipeData.id == mealRecipeId);
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RecipeView(
                                  backendClient: widget.backendClient,
                                  recipeData: mealRecipeData,
                                  ingredientsData: widget.ingredientsData,
                                  units: widget.units,
                                  initialServings:
                                      widget.mealsData[index].servings,
                                )));
                  },
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Text(mealRecipeData.name, textScaleFactor: 2.0),
                    Text("Servings: ${widget.mealsData[index].servings}",
                        textScaleFactor: 1.0),
                    Text("Leftovers: ${widget.mealsData[index].isLeftovers}",
                        textScaleFactor: 1.0),
                    Text("Comment: ${widget.mealsData[index].comment}",
                        textScaleFactor: 1.0),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                  ]));
            }));
  }
}
