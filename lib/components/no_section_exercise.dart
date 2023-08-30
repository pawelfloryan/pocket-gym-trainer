import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../model/exercise.dart';
import '../pages/dashboard_page.dart';
import '../pages/section_page.dart';

class NoSectionExerciseComponent extends StatelessWidget {
  List<Exercise> exercises = <Exercise>[];
  late List<String>? prefsComplete = <String>[];
  File? image;
  late void Function()? pickImage;
  late void Function(int index)? setPrefs;
  String exerciseId;
  String exerciseName;

  NoSectionExerciseComponent({
    required this.exercises,
    required this.prefsComplete,
    this.image,
    required this.pickImage,
    required this.setPrefs,
    required this.exerciseId,
    required this.exerciseName,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Colors.white,
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              width: 150,
              height: 135,
              //Image button
              child: image != null
                  ? Image.file(image!)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                      ),
                      onPressed: () {
                        pickImage!();
                      },
                      child: Tooltip(
                        message: RootPage.toolTipsOn
                            ? "Upload your photos here!"
                            : "",
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 70,
                        ),
                      ),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 130,
                  height: 70,
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 18,
                    bottom: 20,
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: AutoSizeText(
                    exerciseName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    minFontSize: 20,
                  ),
                ),
                prefsComplete!.any((element) => element == exerciseId) &&
                        RootPage.workoutStarted == false
                    ? Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 140,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: (() {
                            //TODO
                          }),
                          child: Text(
                            "Go back",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      )
                    : RootPage.workoutStarted
                        ? Container(
                            margin: EdgeInsets.only(left: 30),
                            width: 140,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: (() {
                                //setPrefs!(certainIndex);
                              }),
                              child: Text(
                                "Complete",
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 30),
                            width: 140,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: (() {
                                DashboardPage.currentPage = 0;
                              }),
                              child: Text(
                                "Start a workout",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
              ],
            ),
            prefsComplete!.any((element) => element == exerciseId) &&
                    RootPage.workoutStarted
                ? Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.done,
                        color: Colors.green[600],
                        size: 40,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
