import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabetai2_flutter/application/edit_schedule_view_widget.dart';
import 'package:tabetai2_flutter/application/schedule_meals_list_widget.dart';
import 'package:tabetai2_flutter/application/schedule_summary_view_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class ScheduleView extends StatefulWidget {
  final String scheduleId;
  final List<RecipeData> recipesData;
  final List<IngredientData> ingredientsData;
  final List<String> units;
  final BackendClient backendClient;

  const ScheduleView(
      {required this.scheduleId,
      required this.recipesData,
      required this.ingredientsData,
      required this.units,
      required this.backendClient,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> implements TopicSubscriber {
  late ScheduleData _scheduleData = ScheduleData("", DateTime.now(), []);

  void init() async {
    List<ScheduleData> schedules = await widget.backendClient.subscribe(this, "com.tabetai2.schedules");
    _scheduleData = schedules.firstWhere((element) => element.id == widget.scheduleId);
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
    super.dispose();
  }

  @override
  void onTopicUpdated(String topic, data) {
    setState(() {
      if (topic == "com.tabetai2.schedules") {
        _scheduleData = data.firstWhere((element) => element.id == widget.scheduleId);
      }
    });
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
    DateTime dStart = _scheduleData.startDate;
    DateTime dEnd = dStart.add(Duration(days: _scheduleData.days.length));
    return "Week ${getWeekNumber(dStart)} - ${getWeekNumber(dEnd)}";
  }

  String _dayString(int day) {
    DateTime dStart = _scheduleData.startDate;
    DateTime dCurr = DateTime(dStart.year, dStart.month, dStart.day, dStart.hour);
    dCurr = dCurr.add(Duration(days: day));
    return DateFormat("EEEE").format(dCurr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleString()),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String choice) async {
              if (choice == "Delete") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Deletion"),
                      content: const Text("This will permanently delete the schedule!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.backendClient.removeSchedule(widget.scheduleId);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              } else if (choice == "Edit") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditScheduleViewWidget(
                      backendClient: widget.backendClient,
                      scheduleId: _scheduleData.id,
                      startDate: _scheduleData.startDate,
                      scheduleDaysToModify: _scheduleData.deepCopy().days,
                      recipesData: widget.recipesData,
                      units: widget.units,
                    ),
                  ),
                );
              } else if (choice == "Summary") {
                ScheduleSummaryData summary = await widget.backendClient.scheduleSummary(widget.scheduleId);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ScheduleSummaryView(
                      summary: summary,
                      ingredientsData: widget.ingredientsData,
                      units: widget.units,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {"Edit", "Delete", "Summary"}.map(
                (String choice) {
                  return PopupMenuItem<String>(value: choice, child: Text(choice));
                },
              ).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _scheduleData.days.length,
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
                      mealsData: _scheduleData.days[index].meals,
                      recipesData: widget.recipesData,
                      ingredientsData: widget.ingredientsData,
                      units: widget.units,
                      backendClient: widget.backendClient,
                    )
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
