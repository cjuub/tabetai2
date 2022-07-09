import 'package:grpc/grpc_web.dart';
import 'package:tabetai2_flutter/backend/gen/proto/tabetai2.pb.dart';
import 'package:tabetai2_flutter/backend/gen/proto/tabetai2.pbgrpc.dart';

import 'backend_data.dart';

class BackendCommunicator {
  GrpcWebClientChannel channel;
  late Tabetai2Client stub;

  BackendCommunicator()
      : channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080')) {
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

    return ingredients;
  }

  Future<List<RecipeData>> getRecipes() async {
    List<RecipeData> recipes = [];

    try {
      await for (Recipe recipe in stub.list_recipes(ListRecipesRequest())) {
        List<RecipeIngredientData> ingredientsData = [];
        for (RecipeIngredientEntry recipeIngredient in recipe.ingredients) {
          var quantityData = RecipeIngredientQuantityData(
              recipeIngredient.quantity.amount,
              recipeIngredient.quantity.unit.toString(),
              recipeIngredient.quantity.exponent);
          ingredientsData.add(RecipeIngredientData(
              recipeIngredient.id.toStringUnsigned(), quantityData));
        }
        recipes.add(RecipeData(recipe.id.toStringUnsigned(), recipe.name,
            recipe.servings, ingredientsData, recipe.steps));
      }
    } catch (e) {
      print('Caught error: $e');
    }

    return recipes;
  }

  Stream<bool> subscribe() async* {
    await for (var resp in stub.subscribe(SubscriptionRequest())) {
      yield resp.serverChanged;
    }
  }
}
