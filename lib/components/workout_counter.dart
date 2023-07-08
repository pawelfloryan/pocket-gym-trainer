import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorkoutCounter extends StatelessWidget {
  final ValueListenable<int> number;

  WorkoutCounter(this.number);

  @override
  Widget build(BuildContext context) {
    int clickCount =  number.value; 

    return Center(
      child: Container(
        margin: const EdgeInsets.all(45.0),
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        height: 180,
        child: FloatingActionButton(
          onPressed: () {},
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
