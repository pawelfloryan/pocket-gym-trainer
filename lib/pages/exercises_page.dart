import 'dart:io';
import 'package:PocketGymTrainer/components/new_item_textfield.dart';
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
  static late List<int> exerciseId;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = false;
  bool weightNotClicked = true;
  bool complete = false;
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

  late final List<bool?> prefsComplete;

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
    //getPrefs(ExercisesPage.exerciseId);
  }

  Future<void> setPrefs(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('complete${index}', true);
  }

  //TODO Figure out how to make prefs work
  Future<void> getPrefs(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefsComplete.add(prefs.getBool('complete${index}'));
  }

  void getData(sectionId) async {
    exercises = (await ExerciseService().getExercise(sectionId, decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void createData() async {
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(sectionName),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //context.go('/sections');
              context.pop();
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
                              onPressed: (context) =>
                                  deleteExercise(exercises[index].id!),
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
                                    complete &&
                                            RootPage.workoutStarted &&
                                            prefsComplete.any(
                                                (element) => element == index)
                                        ? Container(
                                            margin: EdgeInsets.only(left: 30),
                                            width: 140,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black),
                                              onPressed: (() {
                                                complete = false;
                                              }),
                                              child: Text(
                                                "Go back",
                                                style: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(left: 30),
                                            width: 140,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black),
                                              onPressed: (() {
                                                ExercisesPage
                                                    .exerciseId[index] = index;
                                                complete = true;
                                                setPrefs(ExercisesPage
                                                    .exerciseId[index]);
                                              }),
                                              child: Text(
                                                "Complete",
                                                style: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                complete && RootPage.workoutStarted
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
