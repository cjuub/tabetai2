import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/edit_recipe_view_widget.dart';
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
  List<String> _units = [];

  @override
  void initState() {
    widget.backendClient.subscribe(this, "com.tabetai2.recipes");
    widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    widget.backendClient.subscribe(this, "com.tabetai2.units");
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.recipes");
    widget.backendClient.unsubscribe(this, "com.tabetai2.ingredients");
    widget.backendClient.unsubscribe(this, "com.tabetai2.units");
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RecipeView(
                              recipeData: _recipes[index],
                              ingredientsData: _ingredients,
                              backendClient: widget.backendClient)));
                },
              ));
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
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditRecipeViewWidget(
                                              title: controller.text,
                                              backendClient:
                                                  widget.backendClient,
                                              ingredientsData: _ingredients,
                                              units: _units)));
                              setState(() {});
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
      } else if (topic == "com.tabetai2.ingredients") {
        _ingredients = data;
      } else {
        _units = data;
      }
    });
  }
}
