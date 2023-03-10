import 'package:flutter/material.dart';

int clickCount = 0;
int counter = 0;
bool workout = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.all(45.0),
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          height: 170,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                clickCount++;
              });
              setState(() {
                workout = true;
              });
            },
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
        TextButton(
          onPressed: () {},
          child: const Text(
            "Start workout!",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
          ),
        ),
        workout
            ? TextButton(
                onPressed: () {
                  setState(() {
                    workout = false;
                  });
                },
                child: const Text(
                  "End workout?",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                ),
              )
            : Text(""),
      ],
    ));
  }
}
