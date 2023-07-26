import 'dart:io';
import 'package:PocketGymTrainer/components/new_item_textfield.dart';
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
                                    left: 20,
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
                                              Icons.add_photo_alternate_outlined,
                                              size: 70,
                                            ),
                                          ),
                                        ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 70,
                                      margin: const EdgeInsets.only(
                                        left: 30,
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
                                      margin: EdgeInsets.only(left: 30),
                                      width: 140,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black),
                                        onPressed: (() {}),
                                        child: Text(
                                          "Complete",
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
