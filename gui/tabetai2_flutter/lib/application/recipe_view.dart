import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/recipe_ingredient_list_widget.dart';
import 'package:tabetai2_flutter/application/recipe_step_list_widget.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipeView extends StatelessWidget {
  final RecipeData recipeData;
  final List<IngredientData> ingredientsData;

  const RecipeView(
      {required this.recipeData, required this.ingredientsData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeData.name),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: RecipeIngredientListWidget(
                  recipeData: recipeData, ingredientsData: ingredientsData)),
          Expanded(
              flex: 8, child: RecipeStepListWidget(recipeData: recipeData)),
        ],
      ),
    );
  }
}
