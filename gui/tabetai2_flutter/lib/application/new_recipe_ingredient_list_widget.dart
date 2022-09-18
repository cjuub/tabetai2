import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class NewRecipeIngredientListWidget extends StatefulWidget {
  final Map<String, IngredientData> ingredientsDataMap = {};
  final List<IngredientData> ingredientsData;
  final List<RecipeIngredientData> recipeIngredientsData;
  final List<String> units;

  NewRecipeIngredientListWidget(
      {required this.ingredientsData,
      required this.recipeIngredientsData,
      required this.units,
      Key? key})
      : super(key: key) {
    for (IngredientData ingredientData in ingredientsData) {
      ingredientsDataMap[ingredientData.id] = ingredientData;
    }
  }

  @override
  State<StatefulWidget> createState() => _NewRecipeIngredientListWidgetState();
}

class _NewRecipeIngredientListWidgetState
    extends State<NewRecipeIngredientListWidget> {
  int _servings = 4;
  late final String defaultIngredientId;
  late final String defaultUnit;

  @override
  void initState() {
    super.initState();

    defaultIngredientId = widget.ingredientsData[0].id;
    defaultUnit = widget.units[0];

    widget.recipeIngredientsData.add(RecipeIngredientData(
        defaultIngredientId, RecipeIngredientQuantityData(0, defaultUnit, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.only(top: 10)),
      Slider(
          value: _servings.toDouble(),
          divisions: 7,
          min: 1,
          max: 8,
          label: _servings.toString(),
          onChanged: (double value) {
            setState(() => {_servings = value.round()});
          }),
      const Padding(padding: EdgeInsets.only(top: 10)),
      ListView.builder(
          shrinkWrap: true,
          itemCount: widget.recipeIngredientsData.length,
          itemBuilder: (BuildContext context, int index) {
            String ingredientId = widget.recipeIngredientsData[index].id;
            return RecipeIngredientWidget(
                defaultIngredientId: defaultIngredientId,
                ingredientsDataMap: widget.ingredientsDataMap,
                ingredientData: widget.ingredientsDataMap[ingredientId]!,
                recipeIngredientData: widget.recipeIngredientsData[index],
                recipeServings: _servings,
                userServings: _servings,
                units: widget.units,
                recipeIngredientsData: widget.recipeIngredientsData,
                index: index);
          }),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
            onPressed: () => {
                  setState(() => {widget.recipeIngredientsData.removeLast()})
                },
            child: const Text("-", textScaleFactor: 3.0)),
        TextButton(
            onPressed: () => {
                  setState(() {
                    RecipeIngredientQuantityData quantity =
                        RecipeIngredientQuantityData(1, widget.units[0], 0);
                    widget.recipeIngredientsData.add(
                        RecipeIngredientData(defaultIngredientId, quantity));
                  })
                },
            child: const Text("+", textScaleFactor: 3.0)),
      ])
    ]);
  }
}

class RecipeIngredientWidget extends StatefulWidget {
  final String defaultIngredientId;
  final Map<String, IngredientData> ingredientsDataMap;
  final IngredientData ingredientData;
  final RecipeIngredientData recipeIngredientData;
  final int recipeServings;
  final int userServings;
  final List<String> units;
  final List<RecipeIngredientData> recipeIngredientsData;
  final int index;

  const RecipeIngredientWidget(
      {required this.defaultIngredientId,
      required this.ingredientsDataMap,
      required this.ingredientData,
      required this.recipeIngredientData,
      required this.recipeServings,
      required this.userServings,
      required this.units,
      required this.recipeIngredientsData,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredientWidget> {
  String selectedIngredientId = "";
  String selectedAmount = "";
  String selectedUnit = "";
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    selectedIngredientId = widget.defaultIngredientId;
    selectedAmount = "0";
    selectedUnit = widget.units[0];
    _controller = TextEditingController(text: "");
  }

  void setRecipeIngredient() {
    int amount = 0;
    int exponent = 0;
    List<String> amountSplit = selectedAmount.split(".");
    if (amountSplit.length > 1) {
      amount = int.parse(amountSplit[0] + amountSplit[1]);
      exponent = -amountSplit[1].length;
    } else {
      amount = int.parse(amountSplit[0]);
    }

    widget.recipeIngredientsData[widget.index] = RecipeIngredientData(
        selectedIngredientId,
        RecipeIngredientQuantityData(amount, selectedUnit, exponent));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Text(ingredientName, textScaleFactor: 1.1),
      DropdownButton<String>(
          value: selectedIngredientId,
          items: widget.ingredientsDataMap.keys.map((String id) {
            return DropdownMenuItem<String>(
                value: id, child: Text(widget.ingredientsDataMap[id]!.name));
          }).toList(),
          onChanged: (String? val) {
            setState(() {
              selectedIngredientId = val ?? "";
              setRecipeIngredient();
            });
          }),
      const Padding(padding: EdgeInsets.only(right: 10)),
      Expanded(
          child: TextField(
              inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
          ],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  selectedAmount = text;
                  setRecipeIngredient();
                });
              })),
      Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                  value: selectedUnit,
                  items: widget.units.map((String unit) {
                    return DropdownMenuItem<String>(
                        value: unit, child: Text(unit));
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      selectedUnit = val ?? "";
                      setRecipeIngredient();
                    });
                  }))),
      const Padding(padding: EdgeInsets.only(right: 10)),
    ]);
  }
}
