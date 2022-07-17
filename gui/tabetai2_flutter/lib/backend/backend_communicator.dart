import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:tabetai2_flutter/backend/gen/proto/tabetai2.pb.dart';
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
