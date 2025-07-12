import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabetai2_flutter/application/edit_schedule_view_widget.dart';
import 'package:tabetai2_flutter/application/schedule_view_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class SchedulesViewWidget extends StatefulWidget {
  const SchedulesViewWidget({Key? key, required this.backendClient}) : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _SchedulesViewWidgetState();
}

class _SchedulesViewWidgetState extends State<SchedulesViewWidget> implements TopicSubscriber {
  List<ScheduleData> _schedules = [];
  List<RecipeData> _recipes = [];
  List<IngredientData> _ingredients = [];
  List<String> _units = [];

  void init() async {
    _schedules = await widget.backendClient.subscribe(this, "com.tabetai2.schedules");
    _recipes = await widget.backendClient.subscribe(this, "com.tabetai2.recipes");
    _ingredients = await widget.backendClient.subscribe(this, "com.tabetai2.ingredients");
    _units = await widget.backendClient.subscribe(this, "com.tabetai2.units");
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

  String _weekString(int index) {
    DateTime dStart = _schedules[index].startDate;
    DateTime dEnd = dStart.add(Duration(days: _schedules[index].days.length));
    return "Week ${getWeekNumber(dStart)} - ${getWeekNumber(dEnd)}";
  }

  String _dateSpanString(int index) {
    DateTime dStart = _schedules[index].startDate;
    DateTime dEnd = dStart.add(Duration(days: _schedules[index].days.length));

    String str =
        "${dStart.year.toString()}-${dStart.month.toString().padLeft(2, "0")}-${dStart.day.toString().padLeft(2, "0")}";
    str += " - ";
    str += "${dEnd.year.toString()}-${dEnd.month.toString().padLeft(2, "0")}-${dEnd.day.toString().padLeft(2, "0")}";
    return str;
  }

  String _mealsString(int index) {
    if (_schedules[index].days.isEmpty) {
      return "";
    }
    DateTime dStart = _schedules[index].startDate;
    String str = "";
    DateTime dCurr = DateTime(dStart.year, dStart.month, dStart.day, dStart.hour);
    for (ScheduleDayData day in _schedules[index].days) {
      str += DateFormat("EEEE").format(dCurr) + ": ";
      for (MealData meal in day.meals) {
        str += "${meal.title}, ";
      }
      str = str.substring(0, str.length - 2);
      str += "\n";
      dCurr = dCurr.add(const Duration(days: 1));
    }
    return str.substring(0, str.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    DateTime firstDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day - 7);
    DateTime lastDate = DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
    return Scaffold(
      body: ListView.builder(
          itemCount: _schedules.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ScheduleView(
                                scheduleId: _schedules[index].id,
                                recipesData: _recipes,
                                backendClient: widget.backendClient,
                                ingredientsData: _ingredients,
                                units: _units)));
                  },
                  child: Container(
                    child: Row(children: [
                      Expanded(
                          flex: 20,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 150, maxHeight: double.infinity),
                            child: Column(children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 40),
                              ),
                              Text(
                                _weekString(index),
                                textScaleFactor: 1.5,
                              ),
                              Center(
                                child: Text(
                                  _dateSpanString(index),
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                          )),
                      Expanded(
                          flex: 80,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 150, maxHeight: double.infinity),
                            child: Text(
                              _mealsString(index),
                              textScaleFactor: 1.2,
                            ),
                          ))
                    ]),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  ))
            ]);
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
                      scheduleDaysToModify: [],
                      recipesData: _recipes,
                      units: _units,
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
      } else if (topic == "com.tabetai2.ingredients") {
        _ingredients = data;
      } else if (topic == "com.tabetai2.units") {
        _units = data;
      }
    });
  }
}
