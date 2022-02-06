import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';

class SchedulesViewWidget extends StatefulWidget {
  const SchedulesViewWidget({Key? key, required this.backendClient}) : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _SchedulesViewWidgetState();
}

class _SchedulesViewWidgetState extends State<SchedulesViewWidget> implements TopicSubscriber {
  @override
  Widget build(BuildContext context) {
    return const Text("Schedules");
  }

  @override
  void onTopicUpdated(String topic, data) {
    // TODO: implement onTopicUpdated
  }
}
