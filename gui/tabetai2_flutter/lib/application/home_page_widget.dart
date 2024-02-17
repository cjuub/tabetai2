import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/recipes_view_widget.dart';
import 'package:tabetai2_flutter/application/schedules_view_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';

import 'home_view_widget.dart';
import 'ingredients_view_widget.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key, required this.title, required this.backendClient}) : super(key: key) {
    subViews.add(HomeViewWidget(backendClient: backendClient));
    subViews.add(IngredientsViewWidget(backendClient: backendClient));
    subViews.add(RecipesViewWidget(backendClient: backendClient));
    subViews.add(SchedulesViewWidget(backendClient: backendClient));
  }

  final String title;
  final BackendClient backendClient;
  final List<Widget> subViews = [];

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  int _currentViewIndex = 0;

  void _setView(int index) {
    setState(() {
      _currentViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.subViews[_currentViewIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentViewIndex,
        onTap: (value) => _setView(value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Ingredients"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Recipes"),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "Schedules"),
        ],
      ),
    );
  }
}
