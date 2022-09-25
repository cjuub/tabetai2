import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';

import 'package:tabetai2_flutter/backend/backend_data.dart';
import 'edit_recipe_ingredient_list_widget.dart';
import 'edit_recipe_step_list_widget.dart';

class EditRecipeViewWidget extends StatefulWidget {
  final String title;
  final BackendClient backendClient;
  final List<IngredientData> ingredientsData;
  final List<String> units;
  final List<RecipeIngredientData> recipeIngredientsData;
  final List<String> steps;
  final String recipeId;

  const EditRecipeViewWidget(
      {Key? key,
      required this.title,
      required this.backendClient,
      required this.ingredientsData,
      required this.units,
      required this.recipeIngredientsData,
      required this.steps,
      required this.recipeId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditRecipeViewState();
}

class _EditRecipeViewState extends State<EditRecipeViewWidget> {
  void addRecipe() {
    if (widget.recipeId.isEmpty) {
      widget.backendClient
          .addRecipe(
          widget.title, 4, widget.recipeIngredientsData, widget.steps);
    } else {
      widget.backendClient
          .updateRecipe(
          widget.recipeId, widget.title, 4, widget.recipeIngredientsData, widget.steps);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              Expanded(
                  flex: 3,
                  child: EditRecipeIngredientListWidget(
                      ingredientsData: widget.ingredientsData,
                      recipeIngredientsData: widget.recipeIngredientsData,
                      units: widget.units)),
              const VerticalDivider(),
              const Padding(padding: EdgeInsets.only(left: 70)),
              Expanded(
                  flex: 7,
                  child: EditRecipeStepListWidget(steps: widget.steps)),
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Complete"),
                    content: const Text("Is the recipe ready for publication?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            addRecipe();
                            setState(() {});
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Yes")),
                    ],
                  );
                });
          }),
        ),
        onWillPop: () async {
          return (await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Abort"),
                      content: const Text("Are you sure you want to abort?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("Yes")),
                      ],
                    );
                  })) ??
              false;
        });
  }
}
