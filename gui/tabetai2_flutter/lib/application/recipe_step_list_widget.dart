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
          return RecipeStepWidget(
              stepIndex: index, stepString: recipeData.steps[index]);
        });
  }
}

class RecipeStepWidget extends StatelessWidget {
  final int stepIndex;
  final String stepString;

  const RecipeStepWidget(
      {required this.stepIndex, required this.stepString, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.only(bottom: 50)),
      Row(children: [
        Text("${stepIndex + 1}.",
            textScaleFactor: 1.5, style: const TextStyle(color: Colors.grey)),
        const Padding(
          padding: EdgeInsets.only(right: 50),
        ),
        Flexible(child: Text(stepString, textScaleFactor: 1.5)),
        const Padding(
          padding: EdgeInsets.only(right: 100),
        ),
      ])
    ]);
  }
}
