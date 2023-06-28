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
    final screenSize = MediaQuery.of(context).size;

    final double horizontalMargin = screenSize.width * 0.1;
    final double verticalMargin = screenSize.height * 0.021;

    final double horizontalMarginList = screenSize.width * 0.1;
    final double verticalMarginList = screenSize.height * 0.005;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: verticalMargin,
              ),
              child: const Text(
                "Statistics charts",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: verticalMarginList,
              ),
              child: DropdownButton(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
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
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.5,
              viewportFraction: 1,
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
