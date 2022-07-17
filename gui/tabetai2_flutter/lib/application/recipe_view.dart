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
          const Padding(padding: EdgeInsets.only(left: 20)),
          Expanded(
              flex: 3,
              child: RecipeIngredientListWidget(
                  recipeData: recipeData, ingredientsData: ingredientsData)),
          const VerticalDivider(),
          const Padding(padding: EdgeInsets.only(left: 70)),
          Expanded(
              flex: 7, child: RecipeStepListWidget(recipeData: recipeData)),
        ],
      ),
    );
  }
}
