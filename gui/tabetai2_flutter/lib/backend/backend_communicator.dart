import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:tabetai2_flutter/backend/gen/proto/tabetai2.pbgrpc.dart';

import 'backend_data.dart';
import 'grpc_channel_factory.dart'
    if (dart.library.html) 'grpc_web_channel_factory.dart'
    if (dart.library.io) 'grpc_channel_factory.dart';

class BackendCommunicator {
  late ClientChannelBase channel;
  late Tabetai2Client stub;

  BackendCommunicator() {
    String host = GlobalConfiguration().getValue("host");
    if (kIsWeb) {
      channel = GrpcChannelFactory.create(
          host, GlobalConfiguration().getValue("grpc_http_port"));
    } else {
      channel = GrpcChannelFactory.create(
          host, GlobalConfiguration().getValue("grpc_port"));
    }
    stub = Tabetai2Client(channel);
  }

  bool addIngredient(String name) {
    var request = AddIngredientRequest();
    request.name = name;
    stub.add_ingredient(request);
    return true;
  }

  Future<List<IngredientData>> getIngredients() async {
    List<IngredientData> ingredients = [];
    try {
      await for (var ingredient
          in stub.list_ingredients(ListIngredientsRequest())) {
        ingredients.add(
            IngredientData(ingredient.id.toStringUnsigned(), ingredient.name));
      }
    } catch (e) {
      print('Caught error: $e');
    }

    ingredients
        .sort((IngredientData a, IngredientData b) => a.name.compareTo(b.name));
    return ingredients;
  }

  bool addRecipe(String name, int servings,
      List<RecipeIngredientData> recipeIngredients, List<String> steps) {
    var request = AddRecipeRequest();
    request.name = name;
    request.servings = servings;

    Map<String, Unit> unitMapper = {};
    for (Unit unit in Unit.values) {
      unitMapper[unit.toString()] = unit;
    }

    for (RecipeIngredientData recipeIngredient in recipeIngredients) {
      RecipeIngredientEntry recipeIngredientEntry = RecipeIngredientEntry();
      recipeIngredientEntry.id = Int64.parseInt(recipeIngredient.id);

      Quantity quantity = Quantity();
      quantity.amount = recipeIngredient.quantity.amount;
      quantity.unit = unitMapper[recipeIngredient.quantity.unit]!;
      recipeIngredientEntry.quantity = quantity;

      request.ingredients.add(recipeIngredientEntry);
    }

    for (String step in steps) {
      request.steps.add(step);
    }

    stub.add_recipe(request);
    return true;
  }

  bool updateRecipe(String id, String name, int servings,
      List<RecipeIngredientData> recipeIngredients, List<String> steps) {
    var request = UpdateRecipeRequest();
    request.id = Int64.parseInt(id);
    request.name = name;
    request.servings = servings;

    Map<String, Unit> unitMapper = {};
    for (Unit unit in Unit.values) {
      unitMapper[unit.toString()] = unit;
    }

    for (RecipeIngredientData recipeIngredient in recipeIngredients) {
      RecipeIngredientEntry recipeIngredientEntry = RecipeIngredientEntry();
      recipeIngredientEntry.id = Int64.parseInt(recipeIngredient.id);

      Quantity quantity = Quantity();
      quantity.amount = recipeIngredient.quantity.amount;
      quantity.unit = unitMapper[recipeIngredient.quantity.unit]!;
      recipeIngredientEntry.quantity = quantity;

      request.ingredients.add(recipeIngredientEntry);
    }

    for (String step in steps) {
      request.steps.add(step);
    }

    stub.update_recipe(request);
    return true;
  }

  bool eraseRecipe(String id) {
    var request = EraseRecipeRequest();
    request.id = Int64.parseInt(id);
    stub.erase_recipe(request);
    return true;
  }

  Future<List<RecipeData>> getRecipes() async {
    List<RecipeData> recipes = [];

    try {
      await for (Recipe recipe in stub.list_recipes(ListRecipesRequest())) {
        List<RecipeIngredientData> ingredientsData = [];
        for (RecipeIngredientEntry recipeIngredient in recipe.ingredients) {
          var quantityData = RecipeIngredientQuantityData(
              recipeIngredient.quantity.amount,
              recipeIngredient.quantity.unit.toString());
          ingredientsData.add(RecipeIngredientData(
              recipeIngredient.id.toStringUnsigned(), quantityData));
        }
        recipes.add(RecipeData(recipe.id.toStringUnsigned(), recipe.name,
            recipe.servings, ingredientsData, recipe.steps));
      }
    } catch (e) {
      print('Caught error: $e');
    }

    recipes.sort((RecipeData a, RecipeData b) => a.name.compareTo(b.name));
    return recipes;
  }

  List<String> getUnits() {
    List<String> units = [];
    for (Unit unit in Unit.values) {
      units.add(unit.toString());
    }
    return units;
  }

  bool addSchedule(DateTime startDate, List<ScheduleDayData> scheduleDays) {
    var request = AddScheduleRequest();
    request.startDate =
        "${startDate.year.toString()}-${startDate.month.toString().padLeft(2, "0")}-${startDate.day.toString().padLeft(2, "0")}";

    for (ScheduleDayData dayData in scheduleDays) {
      ScheduleDay scheduleDay = ScheduleDay();
      for (MealData mealData in dayData.meals) {
        Meal meal = Meal();
        meal.servings = mealData.servings;
        meal.recipeId = Int64.parseInt(mealData.recipeId);
        meal.isLeftovers = mealData.isLeftovers;
        meal.comment = mealData.comment;
        scheduleDay.meals.add(meal);
      }

      request.days.add(scheduleDay);
    }

    stub.add_schedule(request);
    return true;
  }

  bool updateSchedule(
      String id, DateTime startDate, List<ScheduleDayData> scheduleDays) {
    var request = UpdateScheduleRequest();
    request.id = Int64.parseInt(id);
    request.startDate =
        "${startDate.year.toString()}-${startDate.month.toString().padLeft(2, "0")}-${startDate.day.toString().padLeft(2, "0")}";

    for (ScheduleDayData dayData in scheduleDays) {
      ScheduleDay scheduleDay = ScheduleDay();
      for (MealData mealData in dayData.meals) {
        Meal meal = Meal();
        meal.servings = mealData.servings;
        meal.recipeId = Int64.parseInt(mealData.recipeId);
        meal.isLeftovers = mealData.isLeftovers;
        meal.comment = mealData.comment;
        scheduleDay.meals.add(meal);
      }

      request.days.add(scheduleDay);
    }

    stub.update_schedule(request);
    return true;
  }

  bool eraseSchedule(String id) {
    var request = EraseScheduleRequest();
    request.id = Int64.parseInt(id);
    stub.erase_schedule(request);
    return true;
  }

  Future<List<ScheduleData>> getSchedules() async {
    List<ScheduleData> schedules = [];

    try {
      await for (Schedule schedule
          in stub.list_schedules(ListSchedulesRequest())) {
        List<ScheduleDayData> scheduleDayData = [];
        for (ScheduleDay scheduleDay in schedule.days) {
          List<MealData> mealData = [];
          for (Meal meal in scheduleDay.meals) {
            mealData.add(MealData(meal.recipeId.toStringUnsigned(),
                meal.servings, meal.isLeftovers, meal.comment));
          }
          scheduleDayData.add(ScheduleDayData(mealData));
        }
        schedules.add(ScheduleData(schedule.id.toStringUnsigned(),
            DateTime.parse(schedule.startDate), scheduleDayData));
      }
    } catch (e) {
      print('Caught error: $e');
    }

    schedules.sort(
        (ScheduleData a, ScheduleData b) => b.startDate.compareTo(a.startDate));
    return schedules;
  }

  Future<ScheduleSummaryData> scheduleSummary(String id) async {
    var request = ScheduleSummaryRequest();
    request.id = Int64.parseInt(id);
    var scheduleSummary = await stub.schedule_summary(request);
    List<ScheduleSummaryIngredientData> ingredients = [];
    for (ScheduleSummaryIngredientEntry entry in scheduleSummary.ingredients) {
      List<RecipeIngredientQuantityData> quantitiesData = [];
      for (Quantity quantity in entry.quantities) {
        quantitiesData.add(RecipeIngredientQuantityData(
            quantity.amount, quantity.unit.toString()));
      }
      ingredients.add(ScheduleSummaryIngredientData(
          entry.id.toStringUnsigned(), quantitiesData));
    }
    return ScheduleSummaryData(ingredients);
  }

  Stream<bool> subscribe() async* {
    await for (var resp in stub.subscribe(SubscriptionRequest())) {
      yield resp.serverChanged;
    }
  }
}
