import 'package:tabetai2_flutter/backend/backend_communicator.dart';

abstract class TopicSubscriber {
  void onTopicUpdated(String topic, dynamic data);
}

class BackendClient {
  final BackendCommunicator _backendCommunicator;
  late final Map<String, List<TopicSubscriber>> _subscribers = {"com.tabetai2.ingredients": [], "com.tabetai2.recipes": []};
  late final _topicDataFunctions = {};
  late final Stream<bool> _backendSubscription;

  BackendClient(this._backendCommunicator) {
    _topicDataFunctions["com.tabetai2.ingredients"] = _backendCommunicator.getIngredients;
    _topicDataFunctions["com.tabetai2.recipes"] = _backendCommunicator.getRecipes;
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
