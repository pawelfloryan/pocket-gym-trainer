import 'package:PocketGymTrainer/model/user_stats.dart';
import 'package:PocketGymTrainer/services/user_stats_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../main.dart';

class WorkoutCounter extends StatefulWidget {
  static late int entry;
  static late ValueNotifier<int> number = ValueNotifier<int>(0);

  @override
  State<WorkoutCounter> createState() => _WorkoutCounterState();
}

class _WorkoutCounterState extends State<WorkoutCounter> {
  UserStats userStats = UserStats();

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  @override
  void initState() {
    super.initState();
    getUserStats();
  }

  void getUserStats() async {
    userStats = (await UserStatsService().getUserStats(jwtToken!, decodedUserId));
    setState(() {
      WorkoutCounter.entry = userStats.entries!;
    });
    print(decodedUserId);
    print(userStats.entries);
  }

  @override
  Widget build(BuildContext context) {
    int clickCount = WorkoutCounter.number.value;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          margin: const EdgeInsets.only(top: 45, bottom: 45),
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          height: 180,
          child: FloatingActionButton(
            onPressed: () {},
            child: ValueListenableBuilder<int>(
              valueListenable: WorkoutCounter.number,
              builder: (context, value, child) {
                return Text(
                  "${WorkoutCounter.number.value + WorkoutCounter.entry}",
                  style: clickCount < 100
                      ? const TextStyle(fontSize: 100)
                      : clickCount < 1000
                          ? const TextStyle(fontSize: 75)
                          : const TextStyle(fontSize: 50),
                );
              },
            ),
          ),
        ),
    );
  }
}
