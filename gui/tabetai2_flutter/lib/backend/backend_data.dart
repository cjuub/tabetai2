class IngredientData {
  final String id;
  final String name;

  IngredientData(this.id, this.name);
}

class RecipeIngredientQuantityData {
  final int amount;
  final String unit;

  RecipeIngredientQuantityData(this.amount, this.unit);
}

class RecipeIngredientData {
  final String id;
  final RecipeIngredientQuantityData quantity;

  RecipeIngredientData(this.id, this.quantity);
}

class RecipeData {
  final String id;
  final String name;
  final List<RecipeIngredientData> ingredients;
  final List<String> steps;

  RecipeData(this.id, this.name, this.ingredients, this.steps);
}
