import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/recipe_view.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class RecipesViewWidget extends StatefulWidget {
  const RecipesViewWidget({Key? key, required this.backendClient})
      : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _RecipesViewWidgetState();
}

class _RecipesViewWidgetState extends State<RecipesViewWidget>
    implements TopicSubscriber {
  List<RecipeData> _recipes = [];
  List<IngredientData> _ingredients = [];

  @override
  void initState() {
    widget.backendClient.subscribe(this, "com.tabetai2.recipes");
    widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.recipes");
    widget.backendClient.unsubscribe(this, "com.tabetai2.ingredients");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      body: GridView.builder(
        itemCount: _recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              height: 50,
              child: InkResponse(
                enableFeedback: true,
                child: Card(child: Text(_recipes[index].name)), 
                onTap: () { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecipeView(recipeData: _recipes[index], ingredientsData: _ingredients))); },
              )
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, crossAxisSpacing: 10),
      ).build(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text("Add Recipe"),
                    content: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Tacos",
                          labelText: "Enter recipe name",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              widget.backendClient
                                  .addIngredient(controller.text);
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
  void onTopicUpdated(String topic, data) async {
    setState(() {
      if (topic == "com.tabetai2.recipes") {
        _recipes = data;
      } else {
        _ingredients = data;
      }
    });
  }
}
