class IngredientData {
  final String id;
  final String name;

  IngredientData(this.id, this.name);
}

class RecipeIngredientQuantityData {
  final double amount;
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
  final int servings;
  final List<RecipeIngredientData> ingredients;
  final List<String> steps;

  RecipeData(this.id, this.name, this.servings, this.ingredients, this.steps);
}

class MealData {
  final String title;
  final int servings;
  final String comment;

  MealData(this.title, this.servings, this.comment);
}

class RecipeMealData extends MealData {
  final String recipeId;

  RecipeMealData(String title, int servings, String comment, this.recipeId) : super(title, servings, comment);
}

class ExternalRecipeMealData extends MealData {
  final String url;

  ExternalRecipeMealData(String title, int servings, String comment, this.url) : super(title, servings, comment);
}

class LeftoversMealData extends MealData {
  LeftoversMealData(String title, int servings, String comment) : super(title, servings, comment);
}

class OtherMealData extends MealData {
  OtherMealData(String title, int servings, String comment) : super(title, servings, comment);
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
