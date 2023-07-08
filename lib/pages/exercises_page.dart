import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
    getData(sectionId);
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

  void editExercise() {}

  Future<void> textFieldShow() async {
    setState(() {
      click += 1;
      temp = click / 2;
      if (temp % 1 == 0) {
        notClicked = true;
      } else {
        notClicked = false;
      }
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
                        startActionPane: ActionPane(
                          extentRatio: 0.15,
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => editExercise(),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                            ),
                          ],
                        ),
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
                          color: Colors.grey[600],
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 0, right: 0, top: 5, bottom: 40),
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
                                      width: 140,
                                      height: 70,
                                      margin: const EdgeInsets.only(
                                        left: 30,
                                        right: 0,
                                        top: 18,
                                        bottom: 20,
                                      ),
                                      padding: EdgeInsets.only(left: 10),
                                      //TODO Figure out how to add scrollbars if necessary
                                      child: exercises[index].name!.length > 15
                                          ? Text(
                                              exercises[index].name!,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontFamily: "Times New Roman",
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : exercises[index].name!.length > 6
                                              ? Text(
                                                  exercises[index].name!,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontFamily:
                                                          "Times New Roman",
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              : exercises[index].name!.length >
                                                      4
                                                  ? Text(
                                                      exercises[index].name!,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 35,
                                                          fontFamily:
                                                              "Times New Roman",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  : Text(
                                                      exercises[index].name!,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 50,
                                                          fontFamily:
                                                              "Times New Roman",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black),
                                        onPressed: (() {}),
                                        child: Text(
                                          "Done!",
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin:
                  const EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: textFieldShow,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Visibility(
            visible: notClicked,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width - 90,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3.5),
                    color: Colors.white),
                margin: EdgeInsets.only(
                  left: 0,
                  right: screenSize.width * 0.15,
                  top: 0,
                  bottom: 10,
                ),
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 7, top: 0, right: 0, bottom: 0),
                  child: TextField(
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
            ),
          ),
        ],
      ),
    );
  }
}
