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

  void _init() async {
    _recipes = await widget.backendClient.subscribe(this, "com.tabetai2.recipes");
    setState(() {});
  }

  @override
  void initState() {
    _init();
    super.initState();
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
    _recipes = await data;
    setState(() {

    });
  }
}
