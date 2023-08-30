import 'dart:io';

import 'package:PocketGymTrainer/components/exercise.dart';
import 'package:PocketGymTrainer/model/exercise.dart';
import 'package:PocketGymTrainer/pages/section_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../components/empty_list.dart';
import '../components/new_item_textfield.dart';
import '../main.dart';
import '../services/exercise_service.dart';

class NoSectionPage extends StatefulWidget {
  const NoSectionPage({super.key});

  @override
  State<NoSectionPage> createState() => _NoSectionPageState();
}

class _NoSectionPageState extends State<NoSectionPage> {
  final _textController = TextEditingController();
  String userPost = '';
  double opacity = 0;

  List<Exercise> exercises = <Exercise>[];
  List<Exercise> exercisesDelete = <Exercise>[];

  Exercise exercise = Exercise();
  Exercise exerciseCreate = Exercise();
  Exercise exerciseDelete = Exercise();

  late List<String> prefsComplete = <String>[];
  File? image;

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    RootPage.display = true;
    getData();
    //getPrefs();
    print(exercises);
  }

  Future<void> getData() async {
    exercises = (await ExerciseService().getNoSectionExercise(decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void createData() async {
    exercise = (await ExerciseService().createExercise(exerciseCreate));
    if (exercise.id == null) {
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
          title: const Text("Too many exercises"),
          content: const Text("Max amount is 15"),
          contentPadding: const EdgeInsets.all(25.0),
        ),
      );
    } else {
      //int lastIndex = exercises.length + SectionPage.exercisesCountedLength;
      //print(lastIndex);
      //if (!RootPage.workoutStarted) {
      //  if (prefsComplete.isEmpty) {
      //    setState(() {
      //      for (int i = 0; i < SectionPage.allExercises.length; i++) {
      //        prefsComplete.add("temp");
      //      }
      //    });
      //  }
      //  prefsComplete.insert(lastIndex, "temp");
      //}
      //exercises.add(exercise);
    }
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  Future<void> addExercise() async {
    setState(() {
      userPost = _textController.text;
      exerciseCreate.name = userPost;
      //exerciseCreate.sectionId = sectionId;
      exerciseCreate.userId = decodedUserId;
      createData();
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      opacity = 0;
      _textController.text = "";
    });
  }

  void deleteData(String exerciseId) async {
    await ExerciseService().deleteExerciseSingle(exerciseId);
    getData();
    exerciseDelete.id = exerciseId;
    exercisesDelete = exercises;
    exercisesDelete.remove(exerciseDelete);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void deleteExercise(String id) {
    setState(() {
      deleteData(id);
      exercises = exercisesDelete;
    });
  }

  Future<void> setPrefs(int index) async {}

  @override
  Widget build(BuildContext context) {
    return exercises.length > 0
        ? Stack(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 195,
                        margin: const EdgeInsets.only(
                          left: 20,
                          top: 15,
                          right: 20,
                          bottom: 5,
                        ),
                        child: Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  deleteExercise(exercises[index].id!);
                                  //prefsComplete.removeAt(
                                  //    index + SectionPage.exercisesCountedLength);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_sharp,
                              ),
                            ],
                          ),
                          child: ExerciseComponent(
                            exercises: exercises,
                            prefsComplete: prefsComplete,
                            pickImage: pickImage,
                            setPrefs: setPrefs,
                            certainIndex: index,
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: exercises.length,
              ),
              NewItemTextField(
                text: "Name of a new exercise",
                opacity: opacity,
                textController: _textController,
                onClicked: () {
                  setState(() {
                    if (opacity == 0) {
                      opacity = 1;
                    } else {
                      opacity = 0;
                    }
                  });
                },
                addElement: addExercise,
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                iconColor: Color.fromARGB(255, 255, 255, 255),
              )
            ],
          )
        : Stack(
            children: [
              EmptyList(
                imagePath: "images/exercise.png",
                text: "Click the button in right bottom\nto add new exercises",
              ),
              NewItemTextField(
                text: "Name of a new exercise",
                opacity: opacity,
                textController: _textController,
                onClicked: () {
                  setState(() {
                    if (opacity == 0) {
                      opacity = 1;
                    } else {
                      opacity = 0;
                    }
                  });
                },
                addElement: addExercise,
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                iconColor: Color.fromARGB(255, 255, 255, 255),
              )
            ],
          );
  }
}
