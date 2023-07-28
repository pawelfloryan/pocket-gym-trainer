import 'dart:io';
import '../components/new_item_textfield.dart';
import '../components/workout_controls.dart';
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

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = false;
  bool enterPrefsCalled = false;
  String exerciseUserPost = '';
  String weightUserPost = '';
  File? image;
  double click = 1;
  double temp = 1;

  List<Exercise> exercises = <Exercise>[];
  List<Exercise> newExercises = <Exercise>[];
  List<Exercise> newExercisesDelete = <Exercise>[];
  Exercise exerciseCreate = Exercise();
  Exercise exercise = Exercise();
  Exercise exerciseDelete = Exercise();
  String exerciseId = "";

  String sectionId = SectionPage.sectionKey;
  String sectionName = SectionPage.sectionName;

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  late List<String> prefsComplete = <String>[];

  Future<void>? enterPrefsFuture;

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
    deletePrefs();
    getPrefs();
    enterPrefs();
  }

  //Fills prefComplete with temporary data to be replaced by the completed exercises indexes
  Future<void> enterPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? tempFilled = prefs.getBool('tempFilled');

    if (!enterPrefsCalled) {
      enterPrefsCalled = true;
      enterPrefsFuture = Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {
                for (int i = 0; i < SectionPage.allExercises.length; i++) {
                  prefsComplete.add("temp");
                }
              }));
    }
    tempFilled = true;
    await prefs.setBool('tempFilled', true);
    print(prefsComplete);
    return enterPrefsFuture;
  }

  //Sets list index of the completed exercise
  Future<void> setPrefs(int index) async {
    await enterPrefs();
    setState(() {
      prefsComplete[index +
          SectionPage.sectionPageKey.currentState!
              .countedExercises(sectionId)] = exercises[index].id!;
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

  //Deletes prefs if a workout is not active
  Future<void> deletePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (WorkoutControls.workoutDone) {
      await prefs.remove('complete');
      Future.delayed(const Duration(milliseconds: 100))
          .then((value) => setState(() {
                WorkoutControls.workoutDone = false;
              }));
    }
  }

  Future<void> getData(sectionId) async {
    exercises = (await ExerciseService().getExercise(sectionId, decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void createData() async {
    prefsComplete.add("temp");
    exercise = (await ExerciseService().createExercise(exerciseCreate))!;
    exercises.add(exercise);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void deleteData(String exerciseId) async {
    await ExerciseService().deleteExercise(exerciseId);
    getData(sectionId);
    exerciseDelete.id = exerciseId;
    newExercisesDelete = exercises;
    newExercisesDelete.remove(exerciseDelete);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
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
      notClicked = false;
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
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
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
                                prefsComplete.removeAt(index);
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
                            )),
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
                                            pickImage();
                                          },
                                          child: const Tooltip(
                                            message: "Upload your photos here!",
                                            child: Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
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
                                            RootPage.workoutStarted == false
                                        ? Container(
                                            margin: EdgeInsets.only(left: 30),
                                            width: 140,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
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
                                        : RootPage.workoutStarted == false
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                width: 140,
                                                height: 40,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.black),
                                                  onPressed: (() {
                                                    setPrefs(index);
                                                    print(prefsComplete);
                                                  }),
                                                  child: Text(
                                                    "Complete",
                                                    style: const TextStyle(
                                                        fontSize: 25),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                width: 140,
                                                height: 40,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  onPressed: (() {
                                                    context.pop();
                                                    DashboardPage.currentPage =
                                                        0;
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
                                prefsComplete.any((element) =>
                                            element == exercises[index].id!) &&
                                        RootPage.workoutStarted == false
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
                ),
              );
            },
            itemCount: exercises.length,
          ),
          NewItemTextField(
            text: "Name of a new exercise",
            notClicked: notClicked,
            textController: _textController,
            onClicked: () {
              setState(() {
                notClicked = !notClicked;
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
