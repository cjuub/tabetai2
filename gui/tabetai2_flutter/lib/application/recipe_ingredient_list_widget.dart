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

  @override
  void initState() {
    super.initState();
    _servings = widget.recipeData.servings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.only(top: 60)),
      Slider(
          value: _servings.toDouble(),
          divisions: 7,
          min: 1,
          max: 8,
          label: _servings.round().toString(),
          onChanged: (double value) {
            setState(() => {_servings = value.round()});
          }),
      const Padding(padding: EdgeInsets.only(top: 50)),
      Expanded(
          child: ListView.builder(
              itemCount: widget.recipeData.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                String ingredientId = widget.recipeData.ingredients[index].id;
                return RecipeIngredientWidget(
                    ingredientData: widget.ingredientsDataMap[ingredientId]!,
                    recipeIngredientData:
                        widget.recipeIngredientsDataMap[ingredientId]!);
              }))
    ]);
  }
}

class RecipeIngredientWidget extends StatelessWidget {
  final IngredientData ingredientData;
  final RecipeIngredientData recipeIngredientData;

  const RecipeIngredientWidget(
      {required this.ingredientData,
      required this.recipeIngredientData,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ingredientName = ingredientData.name;
    RecipeIngredientQuantityData quantity = recipeIngredientData.quantity;
    String amount = quantity.amount.toString() + " " + quantity.unit;
    return Row(children: [
      Text(ingredientName, textScaleFactor: 1.5),
      const Padding(padding: EdgeInsets.only(bottom: 50)),
      Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(amount, textScaleFactor: 1.5))),
      const Padding(padding: EdgeInsets.only(right: 10)),
    ]);
  }
}
