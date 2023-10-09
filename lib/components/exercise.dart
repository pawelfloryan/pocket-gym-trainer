import 'dart:io';

import 'package:PocketGymTrainer/components/exercise_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../model/exercise.dart';
import '../pages/dashboard_page.dart';
import '../pages/section_page.dart';

class ExerciseComponent extends StatelessWidget {
  List<Exercise>? exercises = <Exercise>[];
  late List<String>? prefsComplete = <String>[];
  File? image;
  late void Function()? pickImage;
  late void Function(int index)? setPrefs;
  int certainIndex;

  ExerciseComponent({
    required this.exercises,
    required this.prefsComplete,
    this.image,
    required this.pickImage,
    required this.setPrefs,
    required this.certainIndex,
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
                    exercises?[certainIndex].name ?? "Wait...",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                    minFontSize: 20,
                  ),
                ),
                prefsComplete!.any((element) =>
                            element ==
                            (exercises?[certainIndex].id ?? "Wait...")) &&
                        RootPage.workoutStarted == false
                    ? ExerciseButton(
                        text: "Go back",
                      )
                    : RootPage.workoutStarted
                        ? ExerciseButton(
                            action: () => setPrefs!(certainIndex),
                            text: "Complete",
                          )
                        : ExerciseButton(
                            action: () => context.pop(),
                            text: "Start a workout",
                          ),
              ],
            ),
            prefsComplete!.any((element) =>
                        element ==
                        (exercises?[certainIndex].id ?? "Wait...")) &&
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
