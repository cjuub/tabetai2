import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipeIngredientListWidget extends StatefulWidget {
  final RecipeData recipeData;
  final Map<String, IngredientData> ingredientsDataMap = {};
  final Map<String, RecipeIngredientData> recipeIngredientsDataMap = {};
  final int initialServings;

  RecipeIngredientListWidget(
      {required this.recipeData, required ingredientsData, required this.initialServings, Key? key})
      : super(key: key) {
    for (IngredientData ingredientData in ingredientsData) {
      ingredientsDataMap[ingredientData.id] = ingredientData;
    }
    for (RecipeIngredientData recipeIngredientData in recipeData.ingredients) {
      recipeIngredientsDataMap[recipeIngredientData.id] = recipeIngredientData;
    }
  }

  @override
  State<StatefulWidget> createState() => _RecipeIngredientListWidgetState();
}

class _RecipeIngredientListWidgetState extends State<RecipeIngredientListWidget> {
  int _servings = 4;

  @override
  void initState() {
    super.initState();
    _servings = widget.initialServings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.only(top: 10)),
      Slider(
          value: _servings.toDouble(),
          divisions: 7,
          min: 1,
          max: 8,
          label: _servings.toString(),
          onChanged: (double value) {
            setState(() => {_servings = value.round()});
          }),
      const Padding(padding: EdgeInsets.only(top: 10)),
      Expanded(
          child: ListView.builder(
              itemCount: widget.recipeData.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                String ingredientId = widget.recipeData.ingredients[index].id;
                return RecipeIngredientWidget(
                    ingredientData: widget.ingredientsDataMap[ingredientId]!,
                    recipeIngredientData: widget.recipeIngredientsDataMap[ingredientId]!,
                    recipeServings: widget.recipeData.servings,
                    userServings: _servings);
              }))
    ]);
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
    double amount = (quantity.amount / recipeServings) * userServings;
    String amountStr = amount.toString() + " " + quantity.unit;
    return Row(children: [
      Text(ingredientName, textScaleFactor: 1.1),
      const Padding(padding: EdgeInsets.only(bottom: 30)),
      Expanded(child: Align(alignment: Alignment.centerRight, child: Text(amountStr, textScaleFactor: 1.1))),
      const Padding(padding: EdgeInsets.only(right: 10)),
    ]);
  }
}
