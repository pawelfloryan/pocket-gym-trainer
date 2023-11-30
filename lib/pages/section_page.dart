import 'package:PocketGymTrainer/components/workout_controls.dart';
import 'package:PocketGymTrainer/providers/section_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/empty_list.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../components/new_item_textfield.dart';
import '../model/exercise.dart';
import '../model/section.dart';
import '../pages/login_page.dart';
import '../services/exercise_service.dart';
import '../services/section_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../components/section.dart';

class SectionPage extends ConsumerStatefulWidget {
  const SectionPage({super.key});
  static late var sectionKey;
  static late var sectionName;
  static late var exercisesPerformed;
  static late int sectionIndex = -1;
  static late int exercisesCountedLength = -1;
  static late List<Exercise> certainExercises = <Exercise>[];
  static late List<Exercise> allExercises = <Exercise>[];
  static final GlobalKey<_SectionPageState> sectionPageKey =
      GlobalKey<_SectionPageState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SectionPageState();
}

class _SectionPageState extends ConsumerState<SectionPage> {
  List<Exercise> exercises = <Exercise>[];
  List<Exercise> newExercises = <Exercise>[];
  List<Exercise> exercisesCounted = <Exercise>[];
  List<Exercise> certainExercises = <Exercise>[];

  List<Section> sections = <Section>[];
  List<Section> certainSections = <Section>[];

  final _textController = TextEditingController();
  String userPost = '';
  String sectionName = '';
  double opacity = 0;
  bool editing = false;
  int selectedSectionIndex = -1;

  String sectionId = "";
  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  late List<String> prefsComplete = <String>[];

  Future<void>? enterPrefsFuture;
  bool enterPrefsCalled = false;

  @override
  void initState() {
    super.initState();
    deletePrefs();
    getAllExercises();
    exercisesCompleted();
  }

  void createData() async {
    if ("section.id" == null) {
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
          title: const Text("Too many sections"),
          content: const Text("Max amount is 10"),
          contentPadding: const EdgeInsets.all(25.0),
        ),
      );
    } else {
      //sections.add(section);
      RootPage.sectionsLength++;
    }
    //countedExercises(sections.length-1);
  }

  void deleteExercise(String sectionId) async {
    await ExerciseService().deleteExerciseList(sectionId);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void getAllExercises() async {
    exercises = (await ExerciseService().getAllExercises(decodedUserId));
    setState(() {
      SectionPage.allExercises = exercises;
    });
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  exercisesCountDisplay(int index) {
    newExercises = exercises
        .where((element) => element.sectionId == sections[index].id)
        .toList();
    return newExercises.length;
  }

  @override
  Widget build(BuildContext context) {
    final providedSections =
        ref.watch(SectionsProvider(jwtToken!, decodedUserId));

    return Stack(
      children: <Widget>[
        providedSections.when(
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () => Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                strokeWidth: 6,
              ),
            ),
          ),
          data: (sections) => sections.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          child: Slidable(
                            enabled: !RootPage.workoutStarted,
                            closeOnScroll: true,
                            child: SectionComponent(
                              sections: sections,
                              exercises: exercises,
                              textController: _textController,
                              sectionClicked: () {
                                SectionPage.sectionKey = sections[index].id;
                                SectionPage.sectionName = sections[index].name;
                                SectionPage.exercisesPerformed =
                                    sections[index].exercisesPerformed;
                                SectionPage.sectionIndex = index;
                                editing = false;
                                selectedSectionIndex = -1;
                                countedExercises(index);
                                exercisesCompleted();
                                opacity = 0;
                                context.push('/exercises');
                              },
                              sectionEdited: () {
                                ref
                                    .read(SectionsProvider(
                                            jwtToken!, decodedUserId)
                                        .notifier)
                                    .upsertSection(
                                      sections[index].id!,
                                      Section(
                                          name: _textController.text,
                                          userId: decodedUserId,
                                          exercisesPerformed: sections[index]
                                              .exercisesPerformed),
                                    );
                                setState(() {
                                  _textController.text = "";
                                  editing = false;
                                });
                              },
                              exercisesCountDisplay: (index) {
                                newExercises = exercises
                                    .where((element) =>
                                        element.sectionId == sections[index].id)
                                    .toList();
                                return newExercises.length;
                              },
                              editing: editing,
                              selectedSectionIndex: selectedSectionIndex,
                              certainIndex: index,
                            ),
                            startActionPane: ActionPane(
                              extentRatio: 0.15,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) => setState(() {
                                    if (!editing) {
                                      editing = true;
                                      _textController.text =
                                          sections[index].name!;
                                      selectedSectionIndex = index;
                                    } else {
                                      if (selectedSectionIndex != index) {
                                        editing = true;
                                        _textController.text =
                                            sections[index].name!;
                                        selectedSectionIndex = index;
                                      } else {
                                        editing = false;
                                        _textController.text = "";
                                        selectedSectionIndex = -1;
                                      }
                                    }
                                  }),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon:
                                      !editing || selectedSectionIndex != index
                                          ? Icons.edit
                                          : Icons.subdirectory_arrow_left_sharp,
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    if (sections[index].exercisesPerformed! >
                                        0) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                ref
                                                    .read(SectionsProvider(
                                                            jwtToken!,
                                                            decodedUserId)
                                                        .notifier)
                                                    .deleteSection(
                                                        sections[index].id!,
                                                        jwtToken!);
                                                context.pop();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: 10, bottom: 10),
                                                child: Text(
                                                  "Delete anyway",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  right: 10,
                                                  bottom: 5,
                                                ),
                                                child: Text(
                                                  "Cancel",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                            ),
                                          ],
                                          title: Text(
                                              "Exercise data of ${sections[index].name}"),
                                          content: const Text(
                                            "After deleting this section, data used in the radar chart will be lost!",
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(25.0),
                                        ),
                                      );
                                    } else {
                                      ref
                                          .read(SectionsProvider(
                                                  jwtToken!, decodedUserId)
                                              .notifier)
                                          .deleteSection(
                                              sections[index].id!, jwtToken!);
                                    }
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_sharp,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: sections.length,
                )
              : EmptyList(
                  imagePath: "images/push-up.png",
                  text:
                      "Click the button in right bottom\nto add new exercise sections",
                ),
        ),
        NewItemTextField(
          text: "Name of a new section",
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
                .read(sectionsProvider(jwtToken!, decodedUserId).notifier)
                .createSection(
                  Section(
                    name: _textController.text,
                    userId: decodedUserId,
                    exercisesPerformed: 0,
                  ),
                );
            setState(() {
              opacity = 0;
              _textController.text = "";
            });
            //if(providedSections.hasError)
            return addElement;
          },
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          iconColor: Color.fromARGB(255, 0, 0, 0),
        )
      ],
    );
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

  void countedExercises(int index) {
    if (index > 0) {
      exercisesCounted = exercises.where((element) {
        int sectionIndex =
            sections.indexWhere((section) => section.id == element.sectionId);
        return sectionIndex >= 0 && sectionIndex < index;
      }).toList();
      SectionPage.exercisesCountedLength = exercisesCounted.length;
    } else {
      SectionPage.exercisesCountedLength = 0;
    }
  }

  void exercisesCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? strList = prefs.getStringList('complete') ?? [];
    //It adds into the list but prefs reset only when i enter the exercises

    setState(() {
      prefsComplete = strList;
    });

    certainExercises = exercises.where((element) {
      return strList.contains(element.sectionId);
    }).toList();

    certainSections = sections.where((section) {
      return certainExercises
          .any((exercise) => section.id == exercise.sectionId);
    }).toList();
    SectionPage.certainExercises = certainExercises;
  }
}
