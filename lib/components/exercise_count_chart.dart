import 'dart:math';

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
  double sum = 0;
  double finalValue = 1;

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

    for (int i = 0; i < sections.length; i++) {
      sum += sections[i].exercisesPerformed!;
    }
    setState(() {
      finalValue = (sum / sections.length);
    });
  }

  int? touchedDotCount;

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
                    "Training split",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onPanDown: (details) {
                          double x = details.localPosition.dx;
                          double y = details.localPosition.dy;
                          print(y);
                          double angle = atan2(y, x);
                          int sectionIndex =
                              (angle * sections.length / (2 * pi)).round();

                          if (sectionIndex >= 0 &&
                              sectionIndex < sections.length) {
                            setState(() {
                              touchedDotCount =
                                  sections[sectionIndex].exercisesPerformed;
                            });
                          } else {
                            setState(() {
                              touchedDotCount = null;
                            });
                          }
                        },
                        child: RadarChart(
                          RadarChartData(
                            radarTouchData: RadarTouchData(
                              enabled: true,
                            ),
                            tickCount: 3,
                            ticksTextStyle: TextStyle(color: Colors.transparent),
                            dataSets: [
                              RadarDataSet(
                                dataEntries: sections.map((section) {
                                  return RadarEntry(
                                      value: section.exercisesPerformed!
                                          .toDouble());
                                }).toList(),
                                borderWidth: 3,
                              )
                            ],
                            radarShape: RadarShape.polygon,
                            getTitle: (index, angle) {
                              for (int i = 0; i < sections.length; i++) {
                                if (index == i) {
                                  return RadarChartTitle(
                                      text: sections[i].name!);
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
                      if (touchedDotCount != null)
                        Positioned(
                          top: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${touchedDotCount!}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : CircularProgressIndicator();
  }
}
