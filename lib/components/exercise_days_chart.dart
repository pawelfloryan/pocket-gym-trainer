import 'package:PocketGymTrainer/data/days_chart_data.dart';
import 'package:PocketGymTrainer/model/days_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExerciseDaysChart extends StatelessWidget {
  const ExerciseDaysChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 3,
          minY: 0,
          groupsSpace: 12,
          barTouchData: BarTouchData(enabled: true),
          barGroups: DaysChartData.daysChartData
              .map(
                (data) => BarChartGroupData(
                  x: data.id!,
                  barRods: [
                    BarChartRodData(
                      toY: data.amount!.toDouble(),
                      width: 20,
                      color: Colors.black
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
