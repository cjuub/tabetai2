import 'package:tabetai2_flutter/backend/backend_communicator.dart';

import 'backend_data.dart';

abstract class TopicSubscriber {
  void onTopicUpdated(String topic, dynamic data);
}

class BackendClient {
  final BackendCommunicator _backendCommunicator;
  late final Map<String, List<TopicSubscriber>> _subscribers = {
    "com.tabetai2.ingredients": [],
    "com.tabetai2.recipes": [],
    "com.tabetai2.schedules": [],
    "com.tabetai2.units": []
  };
  late final _topicDataFunctions = {};
  late final Stream<bool> _backendSubscription;

  BackendClient(this._backendCommunicator) {
    _topicDataFunctions["com.tabetai2.ingredients"] =
        _backendCommunicator.getIngredients;
    _topicDataFunctions["com.tabetai2.recipes"] =
        _backendCommunicator.getRecipes;
    _topicDataFunctions["com.tabetai2.schedules"] =
        _backendCommunicator.getSchedules;
    _topicDataFunctions["com.tabetai2.units"] = _backendCommunicator.getUnits;
    _backendSubscription = _backendCommunicator.subscribe();
  }

  void subscribe(TopicSubscriber subscriber, String topic) {
    _subscribers[topic]?.add(subscriber);
    _sendInitialData(subscriber, topic);
  }

  void unsubscribe(TopicSubscriber subscriber, String topic) {
    _subscribers[topic]?.remove(subscriber);
  }

  bool addIngredient(String name) {
    return _backendCommunicator.addIngredient(name);
  }

  bool addRecipe(String name, int servings,
      List<RecipeIngredientData> recipeIngredients, List<String> steps) {
    return _backendCommunicator.addRecipe(
        name, servings, recipeIngredients, steps);
  }

  bool updateRecipe(String id, String name, int servings,
      List<RecipeIngredientData> recipeIngredients, List<String> steps) {
    return _backendCommunicator.updateRecipe(
        id, name, servings, recipeIngredients, steps);
  }

  bool removeRecipe(String id) {
    return _backendCommunicator.eraseRecipe(id);
  }

  bool addSchedule(DateTime startDate, List<ScheduleDayData> scheduleDays) {
    return _backendCommunicator.addSchedule(startDate, scheduleDays);
  }

  bool updateSchedule(
      String id, DateTime startDate, List<ScheduleDayData> scheduleDays) {
    return _backendCommunicator.updateSchedule(id, startDate, scheduleDays);
  }

  void _sendInitialData(TopicSubscriber subscriber, String topic) async {
    var data = await _topicDataFunctions[topic]();
    subscriber.onTopicUpdated(topic, data);
  }

  void handleSubscription() async {
    await for (bool res in _backendSubscription) {
      if (res) {
        _subscribers.forEach((topic, subscribers) async {
          var data = await _topicDataFunctions[topic]();
          for (TopicSubscriber subscriber in subscribers) {
            subscriber.onTopicUpdated(topic, data);
          }
        });
      }
    }
  }
}
