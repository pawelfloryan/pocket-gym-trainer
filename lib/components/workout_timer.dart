import 'package:flutter/material.dart';

class WorkoutTimer extends StatefulWidget {
  const WorkoutTimer({super.key});

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, top: 17),
      child: Text(
        "12:54",
        style: TextStyle(
          fontSize: 36,
          fontFamily: "DigitalDisplay",
        ),
      ),
    );
  }
}
