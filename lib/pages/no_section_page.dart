import 'dart:io';

import 'package:PocketGymTrainer/providers/section_provider.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../components/empty_list.dart';
import '../components/new_item_textfield.dart';
import '../components/no_section_exercise.dart';
import '../main.dart';
import '../model/section.dart';
import '../services/exercise_service.dart';
import '../services/section_services.dart';

class NoSectionPage extends StatefulWidget {
  const NoSectionPage({super.key});

  @override
  State<NoSectionPage> createState() => _NoSectionPageState();
}

class _NoSectionPageState extends State<NoSectionPage> {
  final _textController = TextEditingController();
  String userPost = '';
  double opacity = 0;
  String exerciseId = '';

  List<Exercise> exercises = <Exercise>[];
  List exercisesDelete = [];

  List<Section> sections = <Section>[];
  Exercise exercise = Exercise();
  Exercise exerciseCreate = Exercise();

  List dividedExercises = [];

  late List<String> prefsComplete = <String>[];
  File? image;

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  var _items = <MultiSelectItem<Section>>[];

  Future<List<Section>>? sectionsData;

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
    fetchDataAndDivideExercises();
    //getPrefs();
  }

  Future<void> getSections() async {
    sections = (await SectionService().getSection(jwtToken!, decodedUserId));
    sectionsData = SectionService().getSection(jwtToken!, decodedUserId);
    _items = sections
        .map((section) => MultiSelectItem<Section>(section, section.name!))
        .toList();
  }

  Future<void> getExercises() async {
    exercises = (await ExerciseService().getNoSectionExercise(decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {
              RootPage.noSectionExercisesLength = exercises.length;
            }));
  }

  void divideExercises() {
    List tempDivided = List.of(dividedExercises);
    print(exercises);
    for (var exercise in exercises) {
      if (sections.any((section) => section.id == exercise.sectionId)) {
        int sectionId =
            sections.indexWhere((section) => section.id == exercise.sectionId);
        tempDivided.add({
          'sectionName': sections[sectionId].name,
          'exerciseId': exercise.id,
          'exerciseName': exercise.name,
          'exerciseSectionId': exercise.sectionId
        });
      }
    }

    setState(() {
      dividedExercises = tempDivided;
    });
  }

  Future<void> fetchDataAndDivideExercises() async {
    dividedExercises = [];
    await getSections();
    await getExercises();
    setState(() {
      RootPage.allExercises = exercises;
    });
    divideExercises();
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
      exercises.add(exercise);
      RootPage.noSectionExercisesLength++;
      fetchDataAndDivideExercises();
    }
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  Future<void> addExercise() async {
    setState(() {
      userPost = _textController.text;
      exerciseCreate.name = userPost;
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
    exercisesDelete = dividedExercises;
    setState(() {
      exercisesDelete
          .removeWhere((exercise) => exercise['exerciseId'] == exerciseId);
      dividedExercises = exercisesDelete;
    });
    fetchDataAndDivideExercises();
  }

  Future<void> setPrefs(int index) async {}

  void showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: _items,
          initialValue: [],
          height: 200,
          width: 300,
          onSelectionChanged: (p0) {
            setState(() {
              exerciseCreate.sectionId = p0[0].id;
              if (opacity == 0) {
                opacity = 1;
              } else {
                opacity = 0;
              }
            });
            Navigator.of(ctx).pop();
          },
          confirmText: Text(""),
          cancelText: Text(""),
          title: Text(
            "Select section of this exercise",
            style: TextStyle(fontSize: 20),
          ),
          itemsTextStyle: TextStyle(fontSize: 18),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: sectionsData,
          builder: (((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (RootPage.noSectionExercisesLength > 0) {
                return GroupedListView<dynamic, String>(
                  elements: dividedExercises,
                  groupBy: (section) => section['sectionName'],
                  groupSeparatorBuilder: (value) => Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 195,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    deleteData(index['exerciseId']);
                                    //prefsComplete.removeAt(
                                    //    index + SectionPage.exercisesCountedLength);
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_sharp,
                                ),
                              ],
                            ),
                            child: NoSectionExerciseComponent(
                              exercises: exercises,
                              prefsComplete: prefsComplete,
                              pickImage: pickImage,
                              setPrefs: setPrefs,
                              exerciseId: index['exerciseId'],
                              exerciseName: index['exerciseName'],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                return EmptyList(
                  imagePath: "images/exercise.png",
                  text:
                      "Click the button in right bottom\nto add new exercises",
                );
              }
            } else {
              return Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                  ),
                ),
              );
            }
          })),
        ),
        NewItemTextField(
          text: "Name of a new exercise",
          opacity: opacity,
          textController: _textController,
          onClicked: () {
            showMultiSelect(context);
          },
          addElement: addExercise,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          iconColor: Color.fromARGB(255, 255, 255, 255),
        )
      ],
    );
  }
}
