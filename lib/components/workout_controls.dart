import 'dart:ffi';

import 'package:intl/intl.dart';

import '../components/workout_counter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../components/workout_timer.dart';
import '../main.dart';
import '../model/user_stats.dart';
import '../model/workout.dart';
import '../pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../services/user_stats_service.dart';
import '../services/workout_service.dart';

class WorkoutControls extends StatefulWidget {
  const WorkoutControls({super.key});

  @override
  State<WorkoutControls> createState() => _WorkoutControlsState();
}

class _WorkoutControlsState extends State<WorkoutControls> {
  Workout workout = Workout();
  Workout workoutCreate = Workout();

  UserStats userStats = UserStats();
  UserStats newUserStats = UserStats();
  UserStats userStatsUpsert = UserStats();

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  DateTime workoutDate = DateTime.now();
  String formattedDate = "";
  bool toolTip = false;

  void createData() async {
    await WorkoutService().createWorkout(workoutCreate);
  }

  Future<void> addWorkout() async {
    setState(() {
      formattedDate = DateFormat("yyyy-MM-dd").format(workoutDate);
      workoutCreate.time = WorkoutTimer.finishedTime;
      workoutCreate.workoutDate = formattedDate;
      workoutCreate.userId = decodedUserId;
      createData();
    });
  }

  void getUserEntries() async {
    userStats =
        (await UserStatsService().getUserStats(jwtToken!, decodedUserId));
    if (userStats.entries != null) {
      setState(() {
        WorkoutCounter.number.value = userStats.entries!;
      });
    }
    print(decodedUserId);
    print(userStats.entries);
  }

  void upsertUserEntries() async {
    userStats = (await UserStatsService()
        .upsertUserStats(decodedUserId, userStatsUpsert))!;
    getUserEntries();
    newUserStats = userStats;
    newUserStats.entries = userStatsUpsert.entries;
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void editUserEntries() async {
    setState(() {
      userStatsUpsert.entries = WorkoutCounter.number.value;
      userStatsUpsert.id = decodedUserId;
      upsertUserEntries();
      userStats = newUserStats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          DashboardPage.workoutStart
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: EdgeInsets.only(left: 60, right: 60),
                      width: double.infinity,
                      height: 100,
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            WorkoutTimer.stopTimer();
                            DashboardPage.workoutStart = false;
                            addWorkout();
                            WorkoutCounter.number.value++;
                            editUserEntries();
                          });
                        },
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              MyApp.theme == 0
                                  ? Colors.grey[200]!
                                  : Colors.grey[400]!,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black, width: 3),
                              ),
                            ),
                          ),
                          onPressed: (() {
                            setState(() {
                              toolTip = true;
                              Future.delayed(const Duration(milliseconds: 1500))
                                  .then((value) => setState(() {
                                        toolTip = false;
                                      }));
                            });
                          }),
                          child: Text(
                            "FINISH",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 50),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: toolTip,
                      child: Container(
                        margin: EdgeInsets.only(top: 7),
                        child: Text(
                          "To end your workout double-click",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.only(left: 60, right: 60),
                  width: double.infinity,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400]!,
                          spreadRadius: 2,
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          MyApp.theme == 0
                              ? Colors.grey[200]!
                              : Colors.grey[400]!,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
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
                ),
          DashboardPage.workoutStart
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.only(left: 60, right: 60, top: 23),
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        MyApp.theme == 0
                            ? Colors.grey[200]!
                            : Colors.grey[400]!,
                      ),
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
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[500]!,
                          spreadRadius: 2,
                          blurRadius: 15)
                    ],
                  ),
                  margin: EdgeInsets.only(left: 60, right: 60, top: 30),
                  width: double.infinity,
                  height: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyApp.theme == 0
                          ? Colors.grey[200]!
                          : Colors.grey[400]!,
                    ),
                    onPressed: (() {}),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
                          child: Text(
                            "Last workout:",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 30),
                          ),
                        ),
                        workoutDate == null
                            ? Text(
                                "No workouts",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 30),
                              )
                            : Text(
                                "${workoutDate.day}.${workoutDate.month}.${workoutDate.year}",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 30),
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
