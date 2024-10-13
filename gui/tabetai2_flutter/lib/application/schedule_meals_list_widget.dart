import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/recipe_view.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleMealsListWidget extends StatefulWidget {
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;
  final List<IngredientData> ingredientsData;
  final List<String> units;
  final BackendClient backendClient;

  const ScheduleMealsListWidget(
      {required this.mealsData,
      required this.recipesData,
      required this.ingredientsData,
      required this.units,
      required this.backendClient,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScheduleMealsListWidgetState();
}

class _ScheduleMealsListWidgetState extends State<ScheduleMealsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.mealsData.length,
            itemBuilder: (BuildContext context, int index) {
              MealData mealData = widget.mealsData[index];
              if (mealData is RecipeMealData) {
                String mealRecipeId = mealData.recipeId;
                RecipeData mealRecipeData =
                    widget.recipesData.firstWhere((recipeData) => recipeData.id == mealRecipeId);
                return Material(
                  color: Colors.teal[100],
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => RecipeView(
                            backendClient: widget.backendClient,
                            recipeData: mealRecipeData,
                            ingredientsData: widget.ingredientsData,
                            units: widget.units,
                            initialServings: widget.mealsData[index].servings,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        Text(mealData.title, textScaleFactor: 2.0),
                        Text("Servings: ${mealData.servings}", textScaleFactor: 1.0),
                        Text("Comment: ${mealData.comment}", textScaleFactor: 1.0),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                      ],
                    ),
                  ),
                );
              } else if (mealData is ExternalRecipeMealData) {
                return Material(
                  color: Colors.orange[100],
                  child: InkWell(
                    onTap: () {
                      final Uri url = Uri.parse(mealData.url);
                      launchUrl(url);
                    },
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        Text(mealData.title, textScaleFactor: 2.0),
                        Text("URL: ${mealData.url}", textScaleFactor: 1.0),
                        Text("Servings: ${mealData.servings}", textScaleFactor: 1.0),
                        Text("Comment: ${mealData.comment}", textScaleFactor: 1.0),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                      ],
                    ),
                  ),
                );
              } else if (mealData is LeftoversMealData) {
                return Material(
                  color: Colors.lime[100],
                  child: InkWell(
                    onTap: () {
                      // ???
                    },
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        Text(mealData.title, textScaleFactor: 2.0),
                        Text("Servings: ${mealData.servings}", textScaleFactor: 1.0),
                        Text("Comment: ${mealData.comment}", textScaleFactor: 1.0),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                      ],
                    ),
                  ),
                );
              } else if (mealData is OtherMealData) {
                return Material(
                  color: Colors.red[100],
                  child: InkWell(
                    onTap: () {
                      // ???
                    },
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        Text(mealData.title, textScaleFactor: 2.0),
                        Text("Servings: ${mealData.servings}", textScaleFactor: 1.0),
                        Text("Comment: ${mealData.comment}", textScaleFactor: 1.0),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text("Unknown meal type");
              }
            }));
  }
}
