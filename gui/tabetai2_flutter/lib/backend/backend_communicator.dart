import 'package:grpc/grpc_web.dart';

import 'gen/proto/tabetai2.pbgrpc.dart';

import 'backend_data.dart';

class BackendCommunicator {
  GrpcWebClientChannel channel;
  late Tabetai2Client stub;

  BackendCommunicator()
      : channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080')) {
    stub = Tabetai2Client(channel);
  }

  Future<List<IngredientData>> getIngredients() async {
    List<IngredientData> ingredients = [];
    try {
      await for (var ingredient in stub.list_ingredients(ListIngredientsRequest())) {
        ingredients.add(IngredientData(ingredient.id.toStringUnsigned(), ingredient.name));
      }
    } catch (e) {
      print('Caught error: $e');
    }

    return ingredients;
  }

  Future<List<RecipeData>> getRecipes() async {
    List<RecipeData> recipes = [];
    try {
      await for (var recipe in stub.list_recipes(ListRecipesRequest())) {
        recipes.add(RecipeData(recipe.id.toStringUnsigned(), recipe.name));
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
