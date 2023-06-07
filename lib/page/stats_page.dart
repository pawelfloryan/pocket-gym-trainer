import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gymbro/components/exercise_count_chart.dart';
import 'package:gymbro/components/exercise_days_chart.dart';
import 'package:gymbro/components/exercise_time_chart.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<Widget> charts = const [
    ExerciseCountChart(),
    ExerciseDaysChart(),
    ExerciseTimeChart()
  ];

  List<String> options = const [
    "Training split %",
    "Average workout time",
    "Daily workouts"
  ];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Last workout"), value: "Last workout"),
      DropdownMenuItem(child: Text("Last week"), value: "Last week"),
      DropdownMenuItem(child: Text("Last month"), value: "Last month"),
      DropdownMenuItem(
          child: Text("Since {AccountDate}"), value: "Since {AccountDate}"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 35, right: 60),
          child: const Text(
            "Last workout",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 0, right: 150),
          child: DropdownButton(
            items: dropdownItems,
            value: "Last workout",
            onChanged: (String? value) {},
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 330,
          ),
          items: charts
              .map((item) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3.5),
                    ),
                    child: Center(child: item),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
