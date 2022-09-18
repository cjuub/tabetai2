import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';

import 'package:tabetai2_flutter/backend/backend_data.dart';
import 'new_recipe_ingredient_list_widget.dart';
import 'new_recipe_step_list_widget.dart';

class NewRecipeViewWidget extends StatefulWidget {
  final String title;
  final BackendClient backendClient;
  final List<IngredientData> ingredientsData;
  final List<String> units;

  const NewRecipeViewWidget(
      {Key? key,
      required this.title,
      required this.backendClient,
      required this.ingredientsData,
      required this.units})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewRecipeViewState();
}

class _NewRecipeViewState extends State<NewRecipeViewWidget> {
  List<RecipeIngredientData> recipeIngredientsData = [];
  List<String> steps = [];

  void addRecipe() {
    widget.backendClient
        .addRecipe(widget.title, 4, recipeIngredientsData, steps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 20)),
          Expanded(
              flex: 3,
              child: NewRecipeIngredientListWidget(
                  ingredientsData: widget.ingredientsData,
                  recipeIngredientsData: recipeIngredientsData,
                  units: widget.units)),
          const VerticalDivider(),
          const Padding(padding: EdgeInsets.only(left: 70)),
          Expanded(flex: 7, child: NewRecipeStepListWidget(steps: steps)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        addRecipe();
        Navigator.pop(context);
      }),
    );
  }
}
