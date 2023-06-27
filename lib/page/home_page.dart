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
        ],
      ),
    );
  }
}
