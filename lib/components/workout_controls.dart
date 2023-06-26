import 'package:flutter/material.dart';

class WorkoutControls extends StatefulWidget {
  const WorkoutControls({super.key});

  @override
  State<WorkoutControls> createState() => _WorkoutControlsState();
}

class _WorkoutControlsState extends State<WorkoutControls> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            width: double.infinity,
            height: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.grey[200]!),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.black,
                      width: 3
                    ),
                  ),
                ),
              ),
              onPressed: (() {}),
              child: Text(
                "Start workout",
                style: TextStyle(color: Colors.black87, fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
