import 'dart:async';
import 'dart:io';
import 'package:PocketGymTrainer/components/empty_list.dart';

import '../components/new_item_textfield.dart';
import '../components/workout_controls.dart';
import '../model/section.dart';
import '../pages/dashboard_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../model/exercise.dart';
import '../pages/section_page.dart';
import '../services/exercise_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/section_services.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final _textController = TextEditingController();
  String userPost = '';
  double opacity = 0;
  bool enterPrefsCalled = false;
  String exerciseUserPost = '';
  String weightUserPost = '';
  File? image;
  double click = 1;
  double temp = 1;

  List<Exercise> exercises = <Exercise>[];
  List<Exercise> newExercises = <Exercise>[];
  List<Exercise> newExercisesDelete = <Exercise>[];
  List<Section> sections = <Section>[];

  Exercise exerciseCreate = Exercise();
  Exercise exercise = Exercise();
  Exercise exerciseDelete = Exercise();
  Section section = Section();
  Section sectionUpsert = Section();
  String exerciseId = "";

  String sectionId = SectionPage.sectionKey;
  String sectionName = SectionPage.sectionName;

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  late List<String> prefsComplete = <String>[];

  late Completer<void> enterPrefsCompleter;

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
    getData(sectionId);
    getPrefs();
  }

  //Sets list index of the completed exercise
  Future<void> setPrefs(int index) async {
    if (prefsComplete.isEmpty) {
      setState(() {
        for (int i = 0; i < SectionPage.allExercises.length; i++) {
          prefsComplete.add("temp");
        }
      });
    }
    setState(() {
      prefsComplete[index + SectionPage.exercisesCountedLength] =
          exercises[index].id!;
      SectionPage.exercisesPerformed++;
      print(SectionPage.exercisesPerformed);
      print("object");
      editSection();
    });
  }

  //Gets prefs saved in a pref list to know which exercises are already completed
  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? strList = prefs.getStringList('complete');

    setState(() {
      prefsComplete = strList!;
    });
    print(prefsComplete);
  }

  //All completed exercises are saved into a list of prefs
  Future<void> leavePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('complete', prefsComplete);
  }

  Future<void> getData(sectionId) async {
    exercises = (await ExerciseService().getExercise(sectionId, decodedUserId));
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
      int lastIndex = exercises.length + SectionPage.exercisesCountedLength;
      print(lastIndex);
      if (!RootPage.workoutStarted) {
        if (prefsComplete.isEmpty) {
          setState(() {
            for (int i = 0; i < SectionPage.allExercises.length; i++) {
              prefsComplete.add("temp");
            }
          });
        }
        prefsComplete.insert(lastIndex, "temp");
      }
      exercises.add(exercise);
    }
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void deleteData(String exerciseId) async {
    await ExerciseService().deleteExerciseSingle(exerciseId);
    getData(sectionId);
    exerciseDelete.id = exerciseId;
    newExercisesDelete = exercises;
    newExercisesDelete.remove(exerciseDelete);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void updateExercisesPerformed() async {
    await SectionService().upsertSection(sectionId, sectionUpsert);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void editSection() {
    sectionUpsert.id = sectionId;
    sectionUpsert.name = sectionName;
    sectionUpsert.userId = decodedUserId;
    sectionUpsert.exercisesPerformed = SectionPage.exercisesPerformed;
    updateExercisesPerformed();
  }

  Future<void> addExercise() async {
    setState(() {
      userPost = _textController.text;
      exerciseCreate.name = userPost;
      exerciseCreate.sectionId = sectionId;
      exerciseCreate.userId = decodedUserId;
      createData();
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      opacity = 0;
      _textController.text = "";
      click -= 1;
    });
  }

  void deleteExercise(String id) {
    setState(() {
      exerciseId = id;
      deleteData(exerciseId);
      exercises = newExercisesDelete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(sectionName),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
            leavePrefs();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: exercises.length > 0
          ? Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                        children: <Widget>[
                          Container(
                            height: 195,
                            margin: const EdgeInsets.only(
                                left: 10, top: 10, right: 10, bottom: 5),
                            child: Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteExercise(exercises[index].id!);
                                      prefsComplete.removeAt(index +
                                          SectionPage.exercisesCountedLength);
                                      print(index +
                                          SectionPage.exercisesCountedLength);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_sharp,
                                  ),
                                ],
                              ),
                              child: Material(
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
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                                onPressed: () {
                                                  pickImage();
                                                },
                                                child: Tooltip(
                                                  message: RootPage.toolTipsOn
                                                      ? "Upload your photos here!"
                                                      : "",
                                                  child: Icon(
                                                    Icons
                                                        .add_photo_alternate_outlined,
                                                    size: 70,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              exercises[index].name!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              minFontSize: 20,
                                            ),
                                          ),
                                          prefsComplete.any((element) =>
                                                      element ==
                                                      exercises[index].id) &&
                                                  RootPage.workoutStarted ==
                                                      false
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(left: 30),
                                                  width: 140,
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.black),
                                                    onPressed: (() {
                                                      print(index);
                                                    }),
                                                    child: Text(
                                                      "Go back",
                                                      style: const TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                )
                                              : RootPage.workoutStarted
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 30),
                                                      width: 140,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black),
                                                        onPressed: (() {
                                                          setPrefs(index);
                                                          print(index +
                                                              SectionPage
                                                                  .exercisesCountedLength);
                                                        }),
                                                        child: Text(
                                                          "Complete",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 25),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          left: 30),
                                                      width: 140,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                        onPressed: (() {
                                                          context.pop();
                                                          DashboardPage
                                                              .currentPage = 0;
                                                        }),
                                                        child: Text(
                                                          "Start a workout",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                        ],
                                      ),
                                      prefsComplete.any((element) =>
                                                  element ==
                                                  exercises[index].id!) &&
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
                  text:
                      "Click the button in right bottom\nto add new exercises",
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
            ),
    );
  }
}
