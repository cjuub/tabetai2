import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabetai2_flutter/application/edit_schedule_meals_list_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleViewWidget extends StatefulWidget {
  final BackendClient backendClient;
  final DateTime startDate;
  final String scheduleId;
  final List<ScheduleDayData> scheduleDays;
  final List<RecipeData> recipesData;
  final List<IngredientData> ingredientsData;
  final List<String> units;

  const EditScheduleViewWidget({
    Key? key,
    required this.backendClient,
    required this.startDate,
    required this.scheduleId,
    required this.scheduleDays,
    required this.recipesData,
    required this.ingredientsData,
    required this.units,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleViewState();
}

class _EditScheduleViewState extends State<EditScheduleViewWidget> {
  late final String defaultRecipeId;

  @override
  void initState() {
    super.initState();

    defaultRecipeId = widget.recipesData[0].id;

    if (widget.scheduleDays.isEmpty) {
      widget.scheduleDays.add(ScheduleDayData([MealData(defaultRecipeId, 4, false, "")]));
    }
  }

  void addSchedule() {
    if (widget.scheduleId.isEmpty) {
      widget.backendClient.addSchedule(widget.startDate, widget.scheduleDays);
    } else {
      widget.backendClient.updateSchedule(widget.scheduleId, widget.startDate, widget.scheduleDays);
    }
  }

  String _dayString(int day) {
    DateTime dStart = widget.startDate;
    DateTime dCurr = DateTime(dStart.year, dStart.month, dStart.day, dStart.hour);
    dCurr = dCurr.add(Duration(days: day));
    return DateFormat("EEEE").format(dCurr);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(title: Text(widget.startDate.toString())),
          body: Column(children: [
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.scheduleDays.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
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
                              )),
                          EditScheduleMealsListWidget(
                            mealsData: widget.scheduleDays[index].meals,
                            recipesData: widget.recipesData,
                            ingredientsData: widget.ingredientsData,
                            units: widget.units,
                            backendClient: widget.backendClient,
                          )
                        ],
                      )),
                  const Divider(),
                ]);
              },
            )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  onPressed: () => {
                        setState(() => {widget.scheduleDays.removeLast()})
                      },
                  child: const Text("-", textScaleFactor: 3.0)),
              TextButton(
                  onPressed: () => {
                        setState(() {
                          widget.scheduleDays.add(ScheduleDayData([MealData(defaultRecipeId, 4, false, "")]));
                        })
                      },
                  child: const Text("+", textScaleFactor: 3.0)),
            ])
          ]),
          floatingActionButton: FloatingActionButton(onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Complete"),
                    content: const Text("Is the schedule ready for publication?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            addSchedule();
                            setState(() {});
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Yes")),
                    ],
                  );
                  setState(() {});
                });
          }),
        ),
        onWillPop: () async {
          return (await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Abort"),
                      content: const Text("Are you sure you want to abort?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("Yes")),
                      ],
                    );
                  })) ??
              false;
        });
  }
}
