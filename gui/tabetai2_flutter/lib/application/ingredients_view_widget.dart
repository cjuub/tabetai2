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

  @override
  void initState() {
    widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.ingredients");
    super.dispose();
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
  void onTopicUpdated(String topic, data) {
    setState(() {
      _ingredients = data;
    });
  }
}
