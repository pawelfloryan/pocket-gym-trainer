import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../model/exercise.dart';
import '../page/section_page.dart';
import '../services/exercise_service.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final _textController = TextEditingController();
  final _weightController = TextEditingController();
  String userPost = '';
  bool notClicked = false;
  bool weightNotClicked = true;
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
  }

  void getData(sectionId) async {
    exercises = (await ExerciseService().getExercise(sectionId));
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

  Future<void> textFieldShow() async {
    setState(() {
      click += 1;
      temp = click / 2;
      if (temp % 1 == 0) {
        notClicked = true;
      } else {
        notClicked = false;
      }
      print(click);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sectionName),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
                    exercises.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            height: 190,
                            margin: const EdgeInsets.only(
                                left: 10, top: 10, right: 10, bottom: 5),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Material(
                              elevation: 6,
                              color: Colors.grey,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 0, right: 0, top: 5, bottom: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 0,
                                          top: 0,
                                          bottom: 0),
                                      width: 140,
                                      height: 115,
                                      //Image button
                                      child: image != null
                                          ? Image.file(image!)
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey),
                                              onPressed: () {
                                                pickImage();
                                              },
                                              child: const Tooltip(
                                                message:
                                                    "Upload your photos here!",
                                                child: Icon(
                                                  Icons
                                                      .add_photo_alternate_outlined,
                                                  size: 70,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 174,
                                          height: 40,
                                          margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 0,
                                              top: 13,
                                              bottom: 20),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 5,
                                                bottom: 0),
                                            child: Text(
                                              exercises[index].name!,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 174,
                                          height: 40,
                                          margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: weightNotClicked
                                              ? TextField(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  controller: _weightController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Kilos/Pounds',
                                                    hintStyle: const TextStyle(
                                                        color: Colors.black),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      color: Colors.black,
                                                      onPressed: () {
                                                        weightUserPost =
                                                            _weightController
                                                                .text;
                                                        setState(() {
                                                          weightNotClicked =
                                                              false;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          (Icons.done)),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 0,
                                                      right: 0,
                                                      top: 5,
                                                      bottom: 0),
                                                  child: Text(
                                                    weightUserPost,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                                left: 0, top: 50, right: 0, bottom: 0),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/exercise.png",
                                  scale: 1.5,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, top: 20, right: 0, bottom: 0),
                                  width: 370,
                                  child: const Text(
                                    "Click the button on the right bottom",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 90, top: 0, right: 0, bottom: 0),
                                  width: 350,
                                  child: const Text(
                                    "to add new exercises",
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
            itemCount: exercises.length,
          ),
          Visibility(
          visible: notClicked,
          child: Container(
            margin: EdgeInsets.only(
                left: 18,
                right: 0,
                top: MediaQuery.of(context).size.height - 200,
                bottom: 5),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 90,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3.5),
                      color: Colors.white),
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 7, top: 0, right: 0, bottom: 0),
                    child: TextField(
                      autofocus: true,
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Name of a new section',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          color: Colors.black,
                          onPressed: addExercise,
                          icon: Icon((Icons.done)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: textFieldShow,
        child: Icon(Icons.add),
      ),
    );
  }
}
