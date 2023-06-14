import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<RadarEntry> radarData = <RadarEntry>[
  RadarEntry(value: 1.0),
  RadarEntry(value: 2.0),
  RadarEntry(value: 3.0),
];

class ExerciseCountChart extends StatelessWidget {
  const ExerciseCountChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: 30,
            ),
            child: const Text(
              "Exercise performance",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: RadarChart(
              RadarChartData(
                dataSets: [RadarDataSet(dataEntries: radarData)],
                radarShape: RadarShape.polygon,
                getTitle: (index, angle) {
                  if (index == 0)
                    return RadarChartTitle(text: "Arms");
                  else if (index == 1)
                    return RadarChartTitle(text: "Back");
                  else
                    return RadarChartTitle(text: "Legs");
                },
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
                titlePositionPercentageOffset: 0.15,
              ),
              swapAnimationDuration: Duration(milliseconds: 150),
              swapAnimationCurve: Curves.linear,
            ),
          ),
        ],
      ),
    );
  }
}
