import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:PocketGymTrainer/components/empty_list.dart';
import 'package:PocketGymTrainer/components/exercise.dart';
import 'package:PocketGymTrainer/providers/exercise_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class ExercisesPage extends ConsumerStatefulWidget {
  const ExercisesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends ConsumerState<ExercisesPage> {
  final _textController = TextEditingController();
  String userPost = '';
  double opacity = 0;
  File? image;
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
  Future<List<Exercise>>? exercisesData;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  Future<void> getData(sectionId) async {
    await (exercisesData =
        ExerciseService().getExercise(sectionId, decodedUserId));
    exercises = (await exercisesData) ?? [];
    setState(() {
      exercises = exercises..sort((ex1, ex2) => ex1.name!.compareTo(ex2.name!));
    });
  }

  Future<Exercise> createData() async {
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
    }
    return exercise;
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

  void deleteExercise(String id) {
    setState(() {
      exerciseId = id;
      deleteData(exerciseId);
      exercises = newExercisesDelete;
    });
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

  @override
  Widget build(BuildContext context) {
    final providedExercises =
        ref.watch(ExercisesProvider(sectionId, decodedUserId));

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
      body: Stack(
        children: <Widget>[
          providedExercises.when(
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ),
            ),
            data: (exercises) => exercises.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 195,
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              right: 10,
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
                                      //prefsComplete.removeAt(index +
                                      //    SectionPage.exercisesCountedLength);
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
                                image: image,
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
                  )
                : EmptyList(
                    imagePath: "images/exercise.png",
                    text:
                        "Click the button in right bottom\nto add new exercises",
                  ),
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
            addElement: () {
              final addElement = ref
                  .read(exercisesProvider(sectionId, jwtToken!).notifier)
                  .createExercise(
                    Exercise(
                      name: _textController.text,
                      sectionId: sectionId,
                      userId: decodedUserId,
                    ),
                  );
              setState(() {
                opacity = 0;
                _textController.text = "";
              });
              return addElement;
            },
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            iconColor: Color.fromARGB(255, 255, 255, 255),
          )
        ],
      ),
    );
  }

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
      print("object");
      editSection();
    });
  }

  //Gets prefs saved in a pref list to know which exercises are already completed
  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? strList = prefs.getStringList('complete');

    setState(() {
      prefsComplete = strList ?? [];
    });
  }

  //All completed exercises are saved into a list of prefs
  Future<void> leavePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('complete', prefsComplete);
  }
}
