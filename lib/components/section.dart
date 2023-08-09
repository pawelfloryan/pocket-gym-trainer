import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../model/exercise.dart';
import '../model/section.dart';
import '../pages/section_page.dart';

class SectionComponent extends StatelessWidget {
  List<Section> sections = <Section>[];
  List<Exercise> exercises = <Exercise>[];
  late var textController = TextEditingController();
  late void Function() sectionClicked;
  late void Function() sectionEdited;
  late int Function(int index) exercisesCountDisplay;
  bool editing = false;
  int selectedSectionIndex = -1;

  SectionComponent({
    required this.sections,
    required this.exercises,
    required this.textController,
    required this.sectionClicked,
    required this.sectionEdited,
    required this.exercisesCountDisplay,
    required this.editing,
    required this.selectedSectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      child: ElevatedButton(
        onPressed: () {
          sectionClicked();
        },
        child: !editing || selectedSectionIndex != SectionPage.sectionIndex
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Center(
                        child: AutoSizeText(
                          sections[SectionPage.sectionIndex].name!,
                          style: const TextStyle(
                            fontSize: 70,
                          ),
                          minFontSize: 40,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  RootPage.workoutStarted
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: exercises.any((element) =>
                                      element.sectionId ==
                                      sections[SectionPage.sectionIndex].id)
                                  //        &&
                                  //SectionPage
                                  //    .certainExercises
                                  //    .any((element) =>
                                  //        element
                                  //            .sectionId ==
                                  //        sections[
                                  //                index]
                                  //            .id)
                                  ? Text(
                                      //"${SectionPage.certainExercises.length}/${exercisesCountDisplay(index)}",
                                      "${exercisesCountDisplay(SectionPage.sectionIndex)}",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    )
                                  : Text("0/0"),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                          ),
                        )
                ],
              )
            : Container(
                margin: const EdgeInsets.only(left: 7, right: 10),
                child: TextField(
                  cursorColor: Colors.white,
                  autofocus: true,
                  controller: textController,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    suffixIcon: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        sectionEdited();
                      },
                      icon: Icon(
                        Icons.done,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
