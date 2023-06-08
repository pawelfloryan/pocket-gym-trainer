import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/exercise_count_chart.dart';
import '../components/exercise_days_chart.dart';
import '../components/exercise_time_chart.dart';

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

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 35, right: 65),
              child: const Text(
                "Statistics charts",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 215),
              padding: EdgeInsets.only(left: 10),
              child: DropdownButton(
                items: dropdownItems,
                value: "Last workout",
                onChanged: (String? value) {},
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey[500]!,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1),
          ]),
          margin: EdgeInsets.only(left:30, right: 30, bottom: 30),
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            items: charts
                .map(
                  (item) => Container(
                    child: Center(child: item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
