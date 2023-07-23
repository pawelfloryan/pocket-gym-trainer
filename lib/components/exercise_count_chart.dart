import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/section.dart';
import '../providers/section_provider.dart';
import '../services/section_services.dart';

class ExerciseCountChart extends StatefulWidget {
  const ExerciseCountChart({super.key});

  @override
  State<ExerciseCountChart> createState() => _ExerciseCountChartState();
}

class _ExerciseCountChartState extends State<ExerciseCountChart> {
  List<Section> sections = <Section>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List<Section> data =
        (await SectionService().getSection(jwtToken!, decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {
              sections = data;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return sections.isNotEmpty
        ? Container(
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
                      dataSets: [
                        RadarDataSet(
                            dataEntries: sections.map((section) {
                          return RadarEntry(
                              value: sections.indexOf(section).toDouble());
                        }).toList())
                      ],
                      radarShape: RadarShape.polygon,
                      getTitle: (index, angle) {
                        for (int i = 0; i < sections.length; i++) {
                          if (index == i) {
                            return RadarChartTitle(text: sections[i].name!);
                          }
                        }
                        return RadarChartTitle(text: "Error");
                      },
                      titleTextStyle:
                          TextStyle(color: Colors.black, fontSize: 15),
                      titlePositionPercentageOffset: 0.10,
                    ),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
                  ),
                ),
              ],
            ),
          )
        : CircularProgressIndicator();
  }
}
