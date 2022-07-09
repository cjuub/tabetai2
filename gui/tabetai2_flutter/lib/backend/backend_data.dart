class IngredientData {
  final String id;
  final String name;

  IngredientData(this.id, this.name);
}

class RecipeIngredientQuantityData {
  final int amount;
  final String unit;
  final int exponent;

  RecipeIngredientQuantityData(this.amount, this.unit, this.exponent);
}

class RecipeIngredientData {
  final String id;
  final RecipeIngredientQuantityData quantity;

  RecipeIngredientData(this.id, this.quantity);
}

class RecipeData {
  final String id;
  final String name;
  final int servings;
  final List<RecipeIngredientData> ingredients;
  final List<String> steps;

  RecipeData(this.id, this.name, this.servings, this.ingredients, this.steps);
}
