import 'package:flutter/material.dart';
import './exercises_page.dart';
import '../model/tables.dart';
import '../db/database.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  bool isLoading = false;
  List<Exercise> exercises = <Exercise>[];
  List<NewSection> newSection = <NewSection>[];

  @override
  void initState() {
    super.initState();
    refreshSection();
  }

  Future refreshSection() async {
    setState(() => isLoading = true);
    exercises = await LibreGymDatabase.instance.readAllExercises();
    exercises.forEach((element) { 
      debugPrint("${element.title}");
    });
    newSection = exercises.map((e) => NewSection(exercise: e, notClicked: false,)).toList();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    void addNewSection() {
    setState(() {
      newSection.add(NewSection());
    });
  }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Center(
            child: Column(
              children: <Widget>[
                newSection.isNotEmpty
                    ? Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: newSection,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                            left: 0, top: 50, right: 0, bottom: 0),
                        child: Column(
                          children: [
                            Image.asset(
                              "images/bodybuilder.png",
                              scale: 0.8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, top: 10, right: 0, bottom: 0),
                              width: 370,
                              child: const Text(
                                "Click the button on the right bottom",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 55, top: 0, right: 0, bottom: 0),
                              width: 350,
                              child: const Text(
                                "to add new exercise sections",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewSection,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class NewSection extends StatefulWidget {
  final Exercise? exercise;
  bool notClicked;
  NewSection({super.key, this.exercise, this.notClicked = true});

  @override
  // ignore: no_logic_in_create_state
  State<NewSection> createState() => _NewSection();
}

class _NewSection extends State<NewSection> {
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = true;

  @override
  void initState(){
    super.initState();
    userPost = widget.exercise != null ? widget.exercise!.title : "";
    notClicked = widget.notClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const ExercisesPage();
              },
            ),
          );
        },
        child: notClicked == true
            ? Visibility(
                visible: notClicked,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 0, right: 0, top: 21, bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Name of a new section',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              color: Colors.white,
                              onPressed: addSection,
                              
                              icon: Icon((Icons.done)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Text(
                userPost,
                style: const TextStyle(fontSize: 70),
              ),
      ),
    );
  }

  Future<void> addSection() async {
    userPost = _textController.text;
    setState(() {
      notClicked = false;
    });
    Exercise newExercise = Exercise(title: userPost);
    await LibreGymDatabase.instance.create(newExercise);
  }
}

/*
Container(
                        margin: const EdgeInsets.only(
                            left: 0, top: 50, right: 0, bottom: 0),
                        child: Column(
                          children: [
                            Image.asset(
                              "images/bodybuilder.png",
                              scale: 0.8,
                            ),
                            Text("Click button on the left to add new exercise sections")
                          ],
                        ),
                      ),
                      */