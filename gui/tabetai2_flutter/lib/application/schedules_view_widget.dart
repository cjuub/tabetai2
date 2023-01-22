import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/edit_schedule_view_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class SchedulesViewWidget extends StatefulWidget {
  const SchedulesViewWidget({Key? key, required this.backendClient})
      : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _SchedulesViewWidgetState();
}

class _SchedulesViewWidgetState extends State<SchedulesViewWidget>
    implements TopicSubscriber {
  List<ScheduleData> _schedules = [];
  List<RecipeData> _recipes = [];

  @override
  void initState() {
    widget.backendClient.subscribe(this, "com.tabetai2.schedules");
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.schedules");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    DateTime firstDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day - 7);
    DateTime lastDate =
        DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
    return Scaffold(
      body: ListView.builder(
          itemCount: _schedules.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                height: 50,
                child: Center(
                    child: Text(_schedules[index].startDate.toString())));
          }),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        selectedDate = (await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: firstDate,
          lastDate: lastDate,
        ))!;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditScheduleViewWidget(
                      startDate: selectedDate,
                      backendClient: widget.backendClient,
                      scheduleId: "",
                      scheduleDays: [],
                    )));
      }),
    );
  }

  @override
  void onTopicUpdated(String topic, data) {
    setState(() {
      if (topic == "com.tabetai2.schedules") {
        _schedules = data;
      } else if (topic == "com.tabetai2.recipes") {
        _recipes = data;
      }
    });
  }
}
