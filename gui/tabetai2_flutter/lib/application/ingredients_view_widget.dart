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

  void init() async {
    _ingredients = await widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.ingredients");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      body: ListView.builder(
          itemCount: _ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                height: 50,
                child: Center(child: Text(_ingredients[index].name)));
          }).build(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text("Add Ingredient"),
                    content: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Banana",
                          labelText: "Enter ingredient name",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              widget.backendClient.addIngredient(controller.text);
                              Navigator.pop(context);
                            },
                          )),
                    ));
              });
        },
      ),
    );
  }

  @override
  void onTopicUpdated(String topic, data) {
    setState(() {
      _ingredients = data;
    });
  }
}
