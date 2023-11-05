import 'package:flutter/material.dart';

class EditRecipeStepListWidget extends StatefulWidget {
  final List<String> steps;

  const EditRecipeStepListWidget({required this.steps, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditRecipeStepListState();
}

class _EditRecipeStepListState extends State<EditRecipeStepListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: widget.steps.length,
          itemBuilder: (BuildContext context, int index) {
            return EditRecipeStepWidget(
                steps: widget.steps,
                stepIndex: index,
                stepString: widget.steps[index]);
          }),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
            onPressed: () => {
                  setState(() => widget.steps.removeLast())
                },
            child: const Text("-", textScaleFactor: 3.0)),
        TextButton(
            onPressed: () => {
                  setState(() => widget.steps.add(""))
                },
            child: const Text("+", textScaleFactor: 3.0)),
      ])
    ]);
  }
}

class EditRecipeStepWidget extends StatelessWidget {
  final List<String> steps;
  final int stepIndex;
  final String stepString;
  late final TextEditingController _controller;

  EditRecipeStepWidget(
      {required this.steps,
      required this.stepIndex,
      required this.stepString,
      Key? key})
      : super(key: key) {
    _controller = TextEditingController(text: stepString);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.only(bottom: 30)),
      Row(children: [
        Text("${stepIndex + 1}.",
            textScaleFactor: 1.3, style: const TextStyle(color: Colors.grey)),
        const Padding(
          padding: EdgeInsets.only(right: 50),
        ),
        Flexible(
            child: TextField(
                controller: _controller,
                maxLines: null,
                onChanged: (text) => {steps[stepIndex] = text})),
        const Padding(
          padding: EdgeInsets.only(right: 100),
        ),
      ])
    ]);
  }
}
