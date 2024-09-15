import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleMealsListWidget extends StatefulWidget {
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;
  final List<IngredientData> ingredientsData;
  final List<String> units;
  final BackendClient backendClient;

  EditScheduleMealsListWidget(
      {required this.mealsData,
      required this.recipesData,
      required this.ingredientsData,
      required this.units,
      required this.backendClient,
      Key? key})
      : super(key: key) {}

  @override
  State<StatefulWidget> createState() => _EditScheduleMealsListWidgetState();
}

class _EditScheduleMealsListWidgetState extends State<EditScheduleMealsListWidget> {
  late final String defaultRecipeId;
  late final String defaultRecipeName;

  @override
  void initState() {
    super.initState();

    defaultRecipeName = widget.recipesData[0].name;
    defaultRecipeId = widget.recipesData[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.mealsData.length,
              itemBuilder: (BuildContext context, int index) {
                MealData mealData = widget.mealsData[index];
                return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            int _servings = 4;
                            bool _isLeftovers = false;
                            String _comment = "";
                            return StatefulBuilder(builder: (BuildContext context, setState2) {
                              return SimpleDialog(
                                title: const Text("Select a Meal", textAlign: TextAlign.center),
                                children: [
                                  Slider(
                                      value: _servings.toDouble(),
                                      divisions: 7,
                                      min: 1,
                                      max: 8,
                                      label: _servings.toString(),
                                      onChanged: (double value) {
                                        setState2(() => {_servings = value.round()});
                                      }),
                                  CheckboxListTile(
                                      value: _isLeftovers,
                                      title: const Text(
                                        "Leftovers:",
                                        textAlign: TextAlign.right,
                                      ),
                                      onChanged: (checkBoxValue) {
                                        setState2(() => {_isLeftovers = checkBoxValue!});
                                      }),
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter comment...',
                                    ),
                                    onChanged: (text) {
                                      setState2(() => {_comment = text});
                                    },
                                  ),
                                  Container(
                                      width: double.minPositive + 1000,
                                      child: Column(children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: widget.recipesData.length,
                                            itemBuilder: (BuildContext context, int recipeIndex) {
                                              return InkWell(
                                                child: Text(widget.recipesData[recipeIndex].name,
                                                    textScaleFactor: 2.0, textAlign: TextAlign.center),
                                                onTap: () {
                                                  setState(() {
                                                    widget.mealsData[index] = RecipeMealData(
                                                        widget.recipesData[recipeIndex].name,
                                                        _servings,
                                                        _comment,
                                                        widget.recipesData[recipeIndex].id);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              );
                                            })
                                      ]))
                                ],
                              );
                            });
                          });
                      setState(() {});
                    },
                    child: Column(children: [
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      Text(mealData.title, textScaleFactor: 2.0),
                      Text("Servings: ${widget.mealsData[index].servings}", textScaleFactor: 1.0),
                      Text("Comment: ${widget.mealsData[index].comment}", textScaleFactor: 1.0),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                    ]));
              }),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
                onPressed: () => {
                      setState(() => {widget.mealsData.removeLast()})
                    },
                child: const Text("-", textScaleFactor: 3.0)),
            TextButton(
                onPressed: () => {
                      setState(() {
                        widget.mealsData.add(RecipeMealData(defaultRecipeName, 4, "", defaultRecipeId));
                      })
                    },
                child: const Text("+", textScaleFactor: 3.0)),
          ])
        ]));
  }
}
