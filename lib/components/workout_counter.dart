import 'package:flutter/material.dart';

class WorkoutCounter extends StatelessWidget {
  final count = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: count,
          builder: (context, value, child) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(45.0),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 180,
                child: FloatingActionButton(
                  onPressed: () {
                    count.value++;
                  },
                  child: Text(
                    "$count",
                    style: count.value < 100
                        ? const TextStyle(fontSize: 100)
                        : count.value < 1000
                            ? const TextStyle(fontSize: 75)
                            : const TextStyle(fontSize: 50),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
