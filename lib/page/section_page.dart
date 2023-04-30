import 'package:flutter/material.dart';
import 'package:gymbro/page/exercises_page.dart';
import 'package:gymbro/model/section.dart';
import 'package:uuid/uuid.dart';
import '../db/database.dart';
import 'package:gymbro/services/section_services.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  bool isLoading = false;
  List<Section> sections = <Section>[];
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = true;
  //Uuid uuid = new Uuid();
  //  var uuidS = uuid.toString();
  //  uuidS = "008107e5-a7da-4626-b9a3-a911920332ac";
  //  uuid = uuidS as Uuid;

  @override
  void initState() {
    super.initState();
    getData();
    createData();
  }

  void getData() async {
    sections = (await SectionService().getSection())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  //TODO
  void createData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              children: <Widget>[
                sections.isNotEmpty
                    ? Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 110,
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, right: 20, bottom: 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const ExercisesPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              sections[index].name,
                              style: const TextStyle(fontSize: 70),
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
        itemCount: sections.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createData,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> addSection() async {
    userPost = _textController.text;
    setState(() {
      notClicked = false;
    });
    //Section newSection = Section(name: userPost);
    //await LibreGymDatabase.instance.createSection(newSection);
  }
}


//TODO: It will be shown after clicking the floatingActionButton

//                    Expanded(
//                        child: Container(
//                          width: double.infinity,
//                          height: 110,
//                          margin: const EdgeInsets.only(
//                              left: 20, top: 10, right: 20, bottom: 0),
//                          child: ElevatedButton(
//                            style: ElevatedButton.styleFrom(
//                                backgroundColor: Colors.black),
//                            onPressed: () {
//                              Navigator.of(context).push(
//                                MaterialPageRoute(
//                                  builder: (BuildContext context) {
//                                    return const ExercisesPage();
//                                  },
//                                ),
//                              );
//                            },
//                            child: notClicked == true
//                                ? Visibility(
//                                    visible: notClicked,
//                                    child: Container(
//                                      margin: const EdgeInsets.only(
//                                          left: 0,
//                                          right: 0,
//                                          top: 21,
//                                          bottom: 5),
//                                      child: Column(
//                                        children: [
//                                          Container(
//                                            decoration: BoxDecoration(
//                                                border: Border.all(
//                                                    color: Colors.white)),
//                                            child: TextField(
//                                              style: const TextStyle(
//                                                color: Colors.white,
//                                              ),
//                                              controller: _textController,
//                                              decoration: InputDecoration(
//                                                hintText:
//                                                    'Name of a new section',
//                                                hintStyle: TextStyle(
//                                                    color: Colors.grey),
//                                                border: OutlineInputBorder(),
//                                                suffixIcon: IconButton(
//                                                  color: Colors.white,
//                                                  onPressed: addSection,
//                                                  icon: Icon((Icons.done)),
//                                                ),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  )
//                                : Text(
//                                    userPost,
//                                    style: const TextStyle(fontSize: 70),
//                                  ),
//                          ),
//                        ),
//                      )
//                    : Container(
//                        margin: const EdgeInsets.only(
//                            left: 0, top: 50, right: 0, bottom: 0),
//                        child: Column(
//                          children: [
//                            Image.asset(
//                              "images/bodybuilder.png",
//                              scale: 0.8,
//                            ),
//                            Container(
//                              margin: const EdgeInsets.only(
//                                  left: 20, top: 10, right: 0, bottom: 0),
//                              width: 370,
//                              child: const Text(
//                                "Click the button on the right bottom",
//                                style: TextStyle(fontSize: 22),
//                              ),
//                            ),
//                            Container(
//                              margin: const EdgeInsets.only(
//                                  left: 55, top: 0, right: 0, bottom: 0),
//                              width: 350,
//                              child: const Text(
//                                "to add new exercise sections",
//                                style: TextStyle(fontSize: 22),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),