import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class ScheduleSummaryView extends StatelessWidget {
  final ScheduleSummaryData summary;
  final List<IngredientData> ingredientsData;
  final List<String> units;
  final Map<String, IngredientData> ingredientsDataMap = {};

  ScheduleSummaryView({Key? key, required this.summary, required this.ingredientsData, required this.units})
      : super(key: key) {
    for (IngredientData ingredientData in ingredientsData) {
      ingredientsDataMap[ingredientData.id] = ingredientData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Schedule Summary"),
        ),
        body: Column(children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: summary.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                IngredientData ingredientData = ingredientsDataMap[summary.ingredients[index].id]!;

                final amountFormatter = NumberFormat("#.##");
                String amountStr = "";
                for (RecipeIngredientQuantityData quantity in summary.ingredients[index].quantities) {
                  amountStr += amountFormatter.format(quantity.amount) + " " + quantity.unit + " + ";
                }
                if (amountStr.isNotEmpty) {
                  amountStr = amountStr.substring(0, amountStr.length - 3);
                }
                return Text(ingredientData.name + " " + amountStr);
              })
        ]));
  }
}
