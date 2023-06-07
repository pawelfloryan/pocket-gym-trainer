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
          TextButton(
            onPressed: () {},
            child: const Text(
              "Start workout!",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
            ),
          ),
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
