import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipeIngredientListWidget extends StatelessWidget {
  final RecipeData recipeData;
  final Map<String, IngredientData> ingredientsDataMap = {};
  final Map<String, RecipeIngredientData> recipeIngredientsDataMap = {};

  RecipeIngredientListWidget({required this.recipeData, required ingredientsData, Key? key})
      : super(key: key) {
    for (IngredientData ingredientData in ingredientsData) {
      ingredientsDataMap[ingredientData.id] = ingredientData;
    }
    for (RecipeIngredientData recipeIngredientData in recipeData.ingredients) {
      recipeIngredientsDataMap[recipeIngredientData.id] = recipeIngredientData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recipeData.ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          String ingredientId = recipeData.ingredients[index].id;
          String val = ingredientsDataMap[ingredientId]!.name;
          RecipeIngredientQuantityData quantity =
              recipeIngredientsDataMap[ingredientId]!.quantity;
          val += " " + quantity.amount.toString();
          val += " " + quantity.unit;
          return Container(
            height: 50,
            child: Text(val),
          );
        });
  }
}
