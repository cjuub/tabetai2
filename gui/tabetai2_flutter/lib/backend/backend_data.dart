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

  ScheduleData deepCopy() {
    List<ScheduleDayData> daysCopy = [];
    for (ScheduleDayData day in days) {
      List<MealData> mealsCopy = [];
      for (MealData meal in day.meals) {
        if (meal is RecipeMealData) {
          mealsCopy.add(RecipeMealData(meal.title, meal.servings, meal.comment, meal.recipeId));
        } else if (meal is ExternalRecipeMealData) {
          mealsCopy.add(ExternalRecipeMealData(meal.title, meal.servings, meal.comment, meal.url));
        } else if (meal is LeftoversMealData) {
          mealsCopy.add(LeftoversMealData(meal.title, meal.servings, meal.comment));
        } else if (meal is OtherMealData) {
          mealsCopy.add(OtherMealData(meal.title, meal.servings, meal.comment));
        }
      }
      daysCopy.add(ScheduleDayData(mealsCopy));
    }
    return ScheduleData(id, startDate, daysCopy);
  }
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
