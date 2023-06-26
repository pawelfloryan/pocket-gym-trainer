import 'package:PocketGymTrainer/components/workout_controls.dart';
import 'package:flutter/material.dart';
import '../components/workout_counter.dart';

bool workout = false;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WorkoutCounter(),
          WorkoutControls()
          //workout
          //    ? TextButton(
          //        onPressed: () {
          //          setState(() {
          //            workout = false;
          //          });
          //        },
          //        child: const Text(
          //          "End workout?",
          //          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
          //        ),
          //      )
          //    : Text(""),
        ],
      ),
    );
  }
}
