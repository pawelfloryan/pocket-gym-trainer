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
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              dataEntries: radarData
            )
          ],
        ),
        swapAnimationDuration: Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}