import 'package:PocketGymTrainer/components/workout_timer.dart';
import 'package:PocketGymTrainer/page/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class WorkoutControls extends StatefulWidget {
  const WorkoutControls({super.key});

  @override
  State<WorkoutControls> createState() => _WorkoutControlsState();
}

class _WorkoutControlsState extends State<WorkoutControls> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          DashboardPage.workoutStart
          ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            margin: EdgeInsets.only(left: 60, right: 60),
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.grey[200]!),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
              ),
              onPressed: (() {
                setState(() {
                  WorkoutTimer.stopTimer();
                  DashboardPage.workoutStart = false;
                });
              }),
              child: Text(
                "STOP",
                style: TextStyle(color: Colors.black87, fontSize: 50),
              ),
            ),
          ) 
          : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            margin: EdgeInsets.only(left: 60, right: 60),
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.grey[200]!),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
              ),
              onPressed: (() {
                setState(() {
                  WorkoutTimer.startTimer();
                  DashboardPage.workoutStart = true;
                });
              }),
              child: Text(
                "START",
                style: TextStyle(color: Colors.black87, fontSize: 50),
              ),
            ),
          ),
          DashboardPage.workoutStart
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.only(left: 60, right: 60, top: 30),
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.grey[200]!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black, width: 3),
                        ),
                      ),
                    ),
                    onPressed: (() {
                      WorkoutTimer.pauseTimer();
                    }),
                    child: Text(
                      "PAUSE",
                      style: TextStyle(color: Colors.black87, fontSize: 50),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  margin: EdgeInsets.only(left: 60, right: 60, top: 30),
                  width: double.infinity,
                  height: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: (() {}),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
                          child: Text(
                            "Last workout:",
                            style: TextStyle(color: Colors.black87, fontSize: 30),
                          ),
                        ),
                        Text(
                          "20.06.2023",
                          style: TextStyle(color: Colors.black87, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
