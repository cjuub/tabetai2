import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/recipe_ingredient_list_widget.dart';
import 'package:tabetai2_flutter/application/recipe_step_list_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

import 'edit_recipe_view_widget.dart';

class RecipeView extends StatefulWidget {
  final RecipeData recipeData;
  final List<IngredientData> ingredientsData;
  final BackendClient backendClient;
  final List<String> units;
  final int initialServings;

  const RecipeView(
      {required this.recipeData,
      required this.ingredientsData,
      required this.backendClient,
      required this.units,
      required this.initialServings,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeData.name),
        actions: <Widget>[
          PopupMenuButton<String>(onSelected: (String choice) async {
            if (choice == "Delete") {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Deletion"),
                      content: const Text("This will permanently delete the recipe!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              widget.backendClient.removeRecipe(widget.recipeData.id);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("Delete")),
                      ],
                    );
                  });
            } else if (choice == "Edit") {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EditRecipeViewWidget(
                            title: widget.recipeData.name,
                            backendClient: widget.backendClient,
                            ingredientsData: widget.ingredientsData,
                            units: widget.units,
                            recipeIngredientsData: widget.recipeData.ingredients,
                            steps: widget.recipeData.steps,
                            recipeId: widget.recipeData.id,
                          )));
              setState(() {});
            }
          }, itemBuilder: (BuildContext context) {
            return {"Edit", "Delete"}.map((String choice) {
              return PopupMenuItem<String>(value: choice, child: Text(choice));
            }).toList();
          }),
        ],
      ),
      body: Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 20)),
          Expanded(
              flex: 3,
              child: RecipeIngredientListWidget(
                  recipeData: widget.recipeData,
                  ingredientsData: widget.ingredientsData,
                  initialServings: widget.initialServings)),
          const Padding(padding: EdgeInsets.only(right: 10)),
          const VerticalDivider(),
          const Padding(padding: EdgeInsets.only(left: 20)),
          Expanded(flex: 7, child: RecipeStepListWidget(recipeData: widget.recipeData)),
        ],
      ),
    );
  }
}
