import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gymbro/model/exercise.dart';

import '../services/exercise_service.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final _exerciseController = TextEditingController();
  final _weightController = TextEditingController();
  bool exerciseNotClicked = true;
  bool weightNotClicked = true;
  String exerciseUserPost = '';
  String weightUserPost = '';
  File? image;

  List<Exercise> exercises = <Exercise>[];

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
    getData();
  }

  void getData() async {
    exercises = (await ExerciseService().getExercise());
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chest exercises"),
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
                                          child: exerciseNotClicked
                                              ? TextField(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  controller:
                                                      _exerciseController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Exercise',
                                                    hintStyle: const TextStyle(
                                                        color: Colors.black),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      color: Colors.black,
                                                      onPressed: () {
                                                        exerciseUserPost =
                                                            _exerciseController
                                                                .text;
                                                        setState(() {
                                                          exerciseNotClicked =
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
                                                    exerciseUserPost,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewExercise,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewExercise() {}
}

class NewExercise extends StatefulWidget {
  const NewExercise({super.key});

  @override
  State<StatefulWidget> createState() => _NewExercise();
}

class _NewExercise extends State<NewExercise> {
  final _exerciseController = TextEditingController();
  final _weightController = TextEditingController();
  bool exerciseNotClicked = true;
  bool weightNotClicked = true;
  String exerciseUserPost = '';
  String weightUserPost = '';

  File? image;

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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Material(
        elevation: 6,
        color: Colors.grey,
        child: Container(
          margin: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 40),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 0, top: 0, bottom: 0),
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
                          message: "Upload your photos here!",
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
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
                        left: 20, right: 0, top: 13, bottom: 20),
                    child: exerciseNotClicked
                        ? TextField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: _exerciseController,
                            decoration: InputDecoration(
                              hintText: 'Exercise',
                              hintStyle: const TextStyle(color: Colors.black),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  exerciseUserPost = _exerciseController.text;
                                  setState(() {
                                    exerciseNotClicked = false;
                                  });
                                },
                                icon: const Icon((Icons.done)),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                                left: 0, right: 0, top: 5, bottom: 0),
                            child: Text(
                              exerciseUserPost,
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
                        left: 20, right: 0, top: 0, bottom: 0),
                    child: weightNotClicked
                        ? TextField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: _weightController,
                            decoration: InputDecoration(
                              hintText: 'Kilos/Pounds',
                              hintStyle: const TextStyle(color: Colors.black),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  weightUserPost = _weightController.text;
                                  setState(() {
                                    weightNotClicked = false;
                                  });
                                },
                                icon: const Icon((Icons.done)),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                                left: 0, right: 0, top: 5, bottom: 0),
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
    );
  }

  /*Widget newExerciseWidget() => Container(
        color: Colors.black,
        width: double.infinity,
        height: 100,
      );*/
}
