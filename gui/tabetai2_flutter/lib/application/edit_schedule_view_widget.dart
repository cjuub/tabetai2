import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_data.dart';

class EditScheduleViewWidget extends StatefulWidget {
  final BackendClient backendClient;
  final DateTime startDate;
  final String scheduleId;
  final List<ScheduleDayData> scheduleDays;

  const EditScheduleViewWidget(
      {Key? key,
      required this.backendClient,
      required this.startDate,
      required this.scheduleId,
      required this.scheduleDays})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScheduleViewState();
}

class _EditScheduleViewState extends State<EditScheduleViewWidget> {
  void addSchedule() {
    if (widget.scheduleId.isEmpty) {
      widget.backendClient.addSchedule(widget.startDate, widget.scheduleDays);
    } else {
      widget.backendClient.updateSchedule(
          widget.scheduleId, widget.startDate, widget.scheduleDays);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(title: Text(widget.startDate.toString())),
          body: Row(
            children: [],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Complete"),
                    content:
                        const Text("Is the schedule ready for publication?"),
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
