import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorkoutCounter extends StatefulWidget {
  static late ValueNotifier<int> number = ValueNotifier<int>(0);

  @override
  State<WorkoutCounter> createState() => _WorkoutCounterState();
}

class _WorkoutCounterState extends State<WorkoutCounter> {
  bool controls = false;
  
  @override
  Widget build(BuildContext context) {
    int clickCount = WorkoutCounter.number.value;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Visibility(
            visible: controls,
            child: Container(
              child: FloatingActionButton(
                onPressed: () {
                  //TODO
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 45, bottom: 45),
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 180,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    controls = !controls;
                    print(controls);
                  });
                },
                child: ValueListenableBuilder<int>(
                  valueListenable: WorkoutCounter.number,
                  builder: (context, value, child) {
                    return Text(
                      WorkoutCounter.number.value.toString(),
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
          ),
          Visibility(
            visible: controls,
            child: Container(
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.remove),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
