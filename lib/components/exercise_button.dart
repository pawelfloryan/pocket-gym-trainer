import 'package:flutter/material.dart';

class ExerciseButton extends StatelessWidget {
  late void Function()? action;
  late String text;

  ExerciseButton({
    this.action,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      width: 115,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: (() {
          action;
        }),
        child: Text(
          "Start a workout",
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
