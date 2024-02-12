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

class MealData {
  final String recipeId;
  final int servings;
  final bool isLeftovers;
  final String comment;

  MealData(this.recipeId, this.servings, this.isLeftovers, this.comment);
}

class ScheduleDayData {
  final List<MealData> meals;

  ScheduleDayData(this.meals);
}

class ScheduleData {
  final String id;
  final DateTime startDate;
  final List<ScheduleDayData> days;

  ScheduleData(this.id, this.startDate, this.days);
}

class ScheduleSummaryIngredientData {
  final String id;
  final List<RecipeIngredientQuantityData> quantities;

  ScheduleSummaryIngredientData(this.id, this.quantities);
}

class ScheduleSummaryData {
  final List<ScheduleSummaryIngredientData> ingredients;

  ScheduleSummaryData(this.ingredients);
}
