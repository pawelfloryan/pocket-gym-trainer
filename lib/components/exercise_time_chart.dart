import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExerciseTimeChart extends StatelessWidget {
  const ExerciseTimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: const Text(
              "Exercise performance",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 10,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 2),
                      FlSpot(2, 4),
                      FlSpot(5, 1),
                      FlSpot(8, 5),
                      FlSpot(10, 3)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
