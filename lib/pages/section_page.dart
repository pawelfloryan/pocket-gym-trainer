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

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});
  static late var sectionKey;
  static late var sectionName;
  static late int sectionIndex = -1;

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  List<Exercise> exercises = <Exercise>[];
  Iterable<Exercise> newExercises = <Exercise>[];

  List<Section> sections = <Section>[];
  List<Section> newSections = <Section>[];
  List<Section> newSectionsDelete = <Section>[];
  Section section = Section();
  Section sectionCreate = Section();
  Section sectionDelete = Section();
  Section sectionUpsert = Section();

  final _textController = TextEditingController();
  String userPost = '';
  String sectionName = '';
  bool notClicked = false;
  bool editing = false;
  int selectedSectionIndex = -1;
  int sectionIndex = -1;

  String sectionId = "";
  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  int exercisesLength = 0;

  @override
  void initState() {
    super.initState();
    getData();
    getAllExercises();
  }

  void getData() async {
    sections = (await SectionService().getSection(jwtToken!, decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void createData() async {
    print(sectionCreate.name);
    section = (await SectionService().createSection(sectionCreate))!;
    sections.add(section);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void deleteData(String sectionId) async {
    await SectionService().deleteSection(sectionId, jwtToken!);
    getData();
    sectionDelete.id = sectionId;
    newSectionsDelete = sections;
    newSectionsDelete.remove(sectionDelete);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void upsertData(String sectionId) async {
    section = (await SectionService().upsertSection(sectionId, sectionUpsert))!;
    getData();
    newSections = sections;
    newSections[sectionIndex].name = sectionUpsert.name;
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  Future<void> addSection() async {
    setState(() {
      userPost = _textController.text;
      sectionCreate.name = userPost;
      sectionCreate.userId = decodedUserId;
      sectionCreate.exercisesPerformed = 0;
      createData();
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      notClicked = false;
      _textController.text = "";
    });
  }

  void deleteSection(String id) {
    setState(() {
      sectionId = id;
      deleteData(sectionId);
      sections = newSectionsDelete;
    });
  }

  void editSection(String id) async {
    setState(() {
      userPost = _textController.text;
      sectionUpsert.name = userPost;
      sectionUpsert.userId = decodedUserId;
      editing = false;
      sectionId = id;
      upsertData(sectionId);
      getData();
      sections = newSections;
      _textController.text = "";
    });
  }

  void getAllExercises() async {
    exercises = (await ExerciseService().getAllExercises(decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  exercisesCountDisplay(int index){
    newExercises = exercises.where((element) => element.sectionId == sections[index].id);
    return newExercises.length;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 110,
                        child: Slidable(
                          closeOnScroll: true,
                          child: Container(
                            width: double.infinity,
                            height: 110,
                            child: ElevatedButton(
                              onPressed: () {
                                SectionPage.sectionKey = sections[index].id;
                                SectionPage.sectionName = sections[index].name;
                                editing = false;
                                selectedSectionIndex = -1;
                                context.push('/exercises');
                              },
                              child: !editing || selectedSectionIndex != index
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 50),
                                            child: Center(
                                              child: Text(
                                                sections[index].name!,
                                                style: const TextStyle(
                                                    fontSize: 70),
                                              ),
                                            ),
                                          ),
                                        ),
                                        RootPage.workoutStarted
                                            ? Expanded(
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    child: exercises.any(
                                                            (element) =>
                                                                element
                                                                    .sectionId ==
                                                                sections[index]
                                                                    .id)
                                                        ? Text(
                                                            "0/${exercisesCountDisplay(index)}",
                                                            style: TextStyle(
                                                                fontSize: 17),
                                                          )
                                                        : Text("0/0"),
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                ),
                                              )
                                      ],
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 10),
                                      child: TextField(
                                        cursorColor: Colors.white,
                                        autofocus: true,
                                        controller: _textController,
                                        style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              sectionIndex = index;
                                              editSection(sections[index].id!);
                                              _textController.text = "";
                                            },
                                            icon: Icon(
                                              Icons.done,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
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
                                icon: !editing || selectedSectionIndex != index
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
                                onPressed: (context) =>
                                    deleteSection(sections[index].id!),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_sharp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: sections.length,
          ),
          NewItemTextField(
            text: "Name of a new section",
            notClicked: notClicked,
            textController: _textController,
            onClicked: () {
              setState(() {
                notClicked = !notClicked;
              });
            },
            addElement: addSection,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            iconColor: Color.fromARGB(255, 0, 0, 0),
          )
        ],
      ),
    );
  }
}
