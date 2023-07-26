import 'package:PocketGymTrainer/model/workout.dart';
import 'package:PocketGymTrainer/services/workout_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../main.dart';

class ExerciseTimeChart extends StatefulWidget {
  const ExerciseTimeChart({super.key});

  @override
  State<ExerciseTimeChart> createState() => _ExerciseTimeChartState();
}

class _ExerciseTimeChartState extends State<ExerciseTimeChart> {
  List<Workout> workouts = <Workout>[];
  List<Workout> weekWorkouts = <Workout>[];
  List<Workout> monthWorkouts = <Workout>[];

  String? jwtToken = RootPage.token;
  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  DateTime now = DateTime.now();
  String day = "";
  String thisWeek = "";
  String thisMonth = "";
  double maxTime = -1;
  int daysInMonth = -1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  int getNumberOfDaysInMonth(int year, int month) {
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    int numberOfDaysInMonth = lastDayOfMonth.day;

    return numberOfDaysInMonth;
  }

  void dateLogic() {
    int year = DateTime.now().year;
    int month = DateTime.now().month;

    day = DateFormat("yyyy-MM-dd").format(now).substring(8, 10);
    thisMonth = DateFormat("yyyy-MM-dd").format(now).substring(5, 7);

    daysInMonth = getNumberOfDaysInMonth(year, month);
  }

  void getData() async {
    workouts = (await WorkoutService().getWorkout(jwtToken!, decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
    dateLogic();

    weekWorkouts = workouts
        .where((workout) => workout.workoutDate?.substring(8, 10) == thisWeek)
        .toList();
    monthWorkouts = workouts
        .where((workout) => workout.workoutDate?.substring(5, 7) == thisMonth)
        .toList();

    maxTime = monthWorkouts
        .map((workout) => workout.time)
        .reduce((max, value) => max! > value! ? max : value)!
        .toDouble();

    maxTime /= 60000;

    print(workouts[0].workoutDate?.substring(8, 10));
    print(monthWorkouts.length.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: const Text(
              "Average workout time",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 1,
                maxX: daysInMonth.toDouble(),
                minY: 0,
                maxY: maxTime,
                lineBarsData: [
                  LineChartBarData(
                      spots: monthWorkouts.map(
                    (workout) {
                      double month =
                          double.parse(workout.workoutDate!.substring(8, 10));
                      return FlSpot(month, workout.time!.toDouble() / 60000);
                    },
                  ).toList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
