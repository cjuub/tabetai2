import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class IngredientsViewWidget extends StatefulWidget {
  const IngredientsViewWidget({Key? key, required this.backendClient}) : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _IngredientsViewWidgetState();

}

class _IngredientsViewWidgetState extends State<IngredientsViewWidget> implements TopicSubscriber {
  List<IngredientData> _ingredients = [];

  void _init() async {
    _ingredients = await widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    setState(() {});
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String ingredientsStr = "";
    for (IngredientData ing in _ingredients) {
      ingredientsStr += ing.name + '; ';
    }
    return Text(ingredientsStr);
  }

  @override
  void onTopicUpdated(String topic, data) async {
    _ingredients = await data;
    setState(() {

    });
  }
}
