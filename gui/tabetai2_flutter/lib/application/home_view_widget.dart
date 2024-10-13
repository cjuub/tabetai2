import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabetai2_flutter/application/schedule_meals_list_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class HomeViewWidget extends StatefulWidget {
  final BackendClient backendClient;

  const HomeViewWidget({Key? key, required this.backendClient}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewWidgetState();
}

class _HomeViewWidgetState extends State<HomeViewWidget> implements TopicSubscriber {
  List<ScheduleData> _schedulesData = [];
  List<RecipeData> _recipesData = [];
  List<IngredientData> _ingredientsData = [];
  List<String> _units = [];
  ScheduleData? _scheduleData;

  @override
  void onTopicUpdated(String topic, data) {
    setState(() {
      if (topic == "com.tabetai2.schedules") {
        _schedulesData = data;
      } else if (topic == "com.tabetai2.recipes") {
        _recipesData = data;
      } else if (topic == "com.tabetai2.ingredients") {
        _ingredientsData = data;
      } else if (topic == "com.tabetai2.units") {
        _units = data;
      }
    });
  }

  void init() async {
    _schedulesData = await widget.backendClient.subscribe(this, "com.tabetai2.schedules");
    _recipesData = await widget.backendClient.subscribe(this, "com.tabetai2.recipes");
    _ingredientsData = await widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    _units = await widget.backendClient.subscribe(this, "com.tabetai2.units");
    _setCurrentSchedule();

    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    widget.backendClient.unsubscribe(this, "com.tabetai2.schedules");
    widget.backendClient.unsubscribe(this, "com.tabetai2.recipes");
    widget.backendClient.unsubscribe(this, "com.tabetai2.ingredients");
    widget.backendClient.unsubscribe(this, "com.tabetai2.units");
    super.dispose();
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  int getWeekNumber(DateTime dateTime) {
    final firstJan = DateTime(dateTime.year, 1, 1);
    final weekNumber = weeksBetween(firstJan, dateTime);
    return weekNumber;
  }

  String _titleString() {
    DateTime dStart = _scheduleData!.startDate;
    DateTime dEnd = dStart.add(Duration(days: _scheduleData!.days.length));
    return "Week ${getWeekNumber(dStart)} - ${getWeekNumber(dEnd)}";
  }

  String _dayString(int day) {
    DateTime dStart = _scheduleData!.startDate;
    DateTime dCurr = DateTime(dStart.year, dStart.month, dStart.day, dStart.hour);
    dCurr = dCurr.add(Duration(days: day));
    return DateFormat("EEEE").format(dCurr);
  }

  void _setCurrentSchedule() {
    for (ScheduleData schedule in _schedulesData) {
      if (schedule.startDate.isBefore(DateTime.now()) &&
          schedule.startDate.add(Duration(days: schedule.days.length)).isAfter(DateTime.now())) {
        _scheduleData = schedule;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentSchedule();

    Text titleToDisplay = const Text("No active schedule for this week");
    Widget scheduleWidgetToDisplay = const Divider();
    if (_scheduleData != null) {
      titleToDisplay = Text(_titleString());
      scheduleWidgetToDisplay = ListView.builder(
        itemCount: _scheduleData!.days.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 40)),
                    SizedBox(
                      width: 150,
                      child: Text(
                        _dayString(index),
                        textScaleFactor: 1.5,
                      ),
                    ),
                    ScheduleMealsListWidget(
                      mealsData: _scheduleData!.days[index].meals,
                      recipesData: _recipesData,
                      ingredientsData: _ingredientsData,
                      units: _units,
                      backendClient: widget.backendClient,
                    )
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: titleToDisplay,
        ),
        body: scheduleWidgetToDisplay);
  }
}
