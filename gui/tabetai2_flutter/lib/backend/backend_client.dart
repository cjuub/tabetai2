import 'package:tabetai2_flutter/backend/backend_communicator.dart';

abstract class TopicSubscriber {
  void onTopicUpdated(String topic, dynamic data);
}

class BackendClient {
  final BackendCommunicator _backendCommunicator;
  final _subscribers = <String, List<TopicSubscriber>>{};
  final _topicDataFunctions = {};

  BackendClient(this._backendCommunicator) {
    _topicDataFunctions["com.tabetai2.ingredients"] = _backendCommunicator.getIngredients;
    _topicDataFunctions["com.tabetai2.recipes"] = _backendCommunicator.getRecipes;
  }

  dynamic subscribe(TopicSubscriber subscriber, String topic) {
    _subscribers[topic]?.add(subscriber);
    return _topicDataFunctions[topic]();
  }
}
