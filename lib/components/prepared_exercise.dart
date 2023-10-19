import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../model/prepared_exercise.dart';

class PreparedExerciseComponent extends StatelessWidget {
  List<PreparedExercise>? preparedExercises = <PreparedExercise>[];
  File? image;
  int certainIndex;

  PreparedExerciseComponent({
    required this.preparedExercises,
    this.image,
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
                      onPressed: () {},
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 60,
                  margin: const EdgeInsets.only(
                    left: 5,
                    top: 18,
                    bottom: 20,
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    preparedExercises?[certainIndex].name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                    minFontSize: 10,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, bottom: 20),
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: (() {}),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Add to your section",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 145),
              child: IconButton(
                onPressed: (() {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, bottom: 10),
                            child: Text(
                              "Close",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        )
                      ],
                      title: Text(
                          "${preparedExercises?[certainIndex].name ?? ""}"),
                      content: Container(
                        height: 80,
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "\u2022 Muscle group: ${preparedExercises?[certainIndex].muscleGroup ?? ""}\n\u2022 Level: ${preparedExercises?[certainIndex].level ?? ""}\n\u2022 Movement type: ${preparedExercises?[certainIndex].p_p ?? ""}",
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(15.0),
                    ),
                  );
                }),
                icon: Icon(
                  color: Colors.white,
                  Icons.info,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
