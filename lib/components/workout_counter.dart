import 'package:flutter/material.dart';

class WorkoutCounter extends StatefulWidget {
  const WorkoutCounter({Key? key}) : super(key: key);

  @override
  _WorkoutCounterState createState() => _WorkoutCounterState();
}

class _WorkoutCounterState extends State<WorkoutCounter> {
  int clickCount = 0;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //decoration: BoxDecoration(
        //  border: Border.all(color: Colors.black),
        //),
        margin: const EdgeInsets.all(45.0),
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        height: 180,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              clickCount++;
            });
          },
          child: Text(
            "$clickCount",
            style: clickCount < 100
                ? const TextStyle(fontSize: 100)
                : clickCount < 1000
                    ? const TextStyle(fontSize: 75)
                    : const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
