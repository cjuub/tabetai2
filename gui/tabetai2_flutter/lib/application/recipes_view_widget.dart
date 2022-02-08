import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipesViewWidget extends StatefulWidget {
  const RecipesViewWidget({Key? key, required this.backendClient}) : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _RecipesViewWidgetState();
}

class _RecipesViewWidgetState extends State<RecipesViewWidget> implements TopicSubscriber {
  List<RecipeData> _recipes = [];

  @override
  void initState() {
    widget.backendClient.subscribe(this, "com.tabetai2.recipes");
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.recipes");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String recipesStr = "";
    for (RecipeData recipe in _recipes) {
      recipesStr += recipe.name + '; ';
    }
    return Text(recipesStr);
  }

  @override
  void onTopicUpdated(String topic, data) async {
    setState(() {
      _recipes = data;
    });
  }
}
