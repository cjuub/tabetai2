import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleSelectRecipeMealDialog extends StatefulWidget {
  final int index;
  final List<MealData> mealsData;
  final List<RecipeData> recipesData;

  const EditScheduleSelectRecipeMealDialog(
      {required this.index, required this.mealsData, required this.recipesData, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleSelectRecipeMealDialogState();
}

class _EditScheduleSelectRecipeMealDialogState extends State<EditScheduleSelectRecipeMealDialog> {
  int _servings = 4;
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Select a Recipe", textAlign: TextAlign.center),
      children: [
        Slider(
          value: _servings.toDouble(),
          divisions: 7,
          min: 1,
          max: 8,
          label: _servings.toString(),
          onChanged: (double value) {
            setState(() {
              _servings = value.round();
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter comment...',
          ),
          onChanged: (text) {
            setState(() {
              _comment = text;
            });
          },
        ),
        SizedBox(
          width: double.minPositive + 1000,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.recipesData.length,
                itemBuilder: (BuildContext context, int recipeIndex) {
                  return InkWell(
                    child:
                        Text(widget.recipesData[recipeIndex].name, textScaleFactor: 2.0, textAlign: TextAlign.center),
                    onTap: () {
                      setState(
                        () {
                          widget.mealsData[widget.index] = RecipeMealData(widget.recipesData[recipeIndex].name,
                              _servings, _comment, widget.recipesData[recipeIndex].id);
                        },
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
