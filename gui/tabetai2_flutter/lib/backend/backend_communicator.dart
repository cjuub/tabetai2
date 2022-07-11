import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc_web.dart';
import 'package:tabetai2_flutter/backend/gen/proto/tabetai2.pb.dart';
import 'package:tabetai2_flutter/backend/gen/proto/tabetai2.pbgrpc.dart';

import 'backend_data.dart';

class BackendCommunicator {
  late GrpcWebClientChannel channel;
  late Tabetai2Client stub;

  BackendCommunicator() {
    String host = GlobalConfiguration().getValue("host");
    String port = GlobalConfiguration().getValue("grpc_http_port");
    channel = GrpcWebClientChannel.xhr(Uri.parse("http://$host:$port"));
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
