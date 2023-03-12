import 'dart:math';

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
    return Expanded(
        child: ListView.builder(
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
                    const Padding(padding: EdgeInsets.only(top: 15)),
                  ]));
            }));
  }
}

class RecipeIngredientWidget extends StatelessWidget {
  final IngredientData ingredientData;
  final RecipeIngredientData recipeIngredientData;
  final int recipeServings;
  final int userServings;

  const RecipeIngredientWidget(
      {required this.ingredientData,
      required this.recipeIngredientData,
      required this.recipeServings,
      required this.userServings,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ingredientName = ingredientData.name;
    RecipeIngredientQuantityData quantity = recipeIngredientData.quantity;
    double amount =
        (quantity.amount * pow(10, quantity.exponent) / recipeServings) *
            userServings;
    String amountStr = amount.toString() + " " + quantity.unit;
    return Row(children: [
      Text(ingredientName, textScaleFactor: 1.1),
      const Padding(padding: EdgeInsets.only(bottom: 30)),
      Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(amountStr, textScaleFactor: 1.1))),
      const Padding(padding: EdgeInsets.only(right: 10)),
    ]);
  }
}
