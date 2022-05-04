import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipeIngredientListWidget extends StatefulWidget {
  final RecipeData recipeData;
  final Map<String, IngredientData> ingredientsDataMap = {};
  final Map<String, RecipeIngredientData> recipeIngredientsDataMap = {};

  RecipeIngredientListWidget(
      {required this.recipeData, required ingredientsData, Key? key})
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

class _RecipeIngredientListWidgetState
    extends State<RecipeIngredientListWidget> {
  int _servings = 4;

  void updateNbrServings(int servings) {
    _servings = servings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Slider(
          value: _servings.toDouble(),
          divisions: 10,
          min: 1,
          max: 10,
          label: _servings.round().toString(),
          onChanged: (double value) {
            setState(() => {updateNbrServings(value.round())});
          }),
      Expanded(
          child: ListView.builder(
              itemCount: widget.recipeData.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                String ingredientId = widget.recipeData.ingredients[index].id;
                String val = widget.ingredientsDataMap[ingredientId]!.name;
                RecipeIngredientQuantityData quantity =
                    widget.recipeIngredientsDataMap[ingredientId]!.quantity;
                val += " " + quantity.amount.toString();
                val += " " + quantity.unit;
                return Container(
                  height: 50,
                  child: Text(val),
                );
              }))
    ]);
  }
}
