import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipeStepListWidget extends StatelessWidget {
  final RecipeData recipeData;

  const RecipeStepListWidget({required this.recipeData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recipeData.steps.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Text("${index + 1}. " + recipeData.steps[index]),
          );
        });
  }
}
