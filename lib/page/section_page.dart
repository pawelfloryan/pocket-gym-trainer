import 'package:flutter/material.dart';
import 'package:gymbro/page/exercises_page.dart';
import 'package:gymbro/model/section.dart';
import 'package:gymbro/res/section_request.dart';
import 'package:uuid/uuid.dart';
import 'package:gymbro/services/section_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  bool isLoading = false;
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = false;
  //Uuid uuid = new Uuid();
  //  var uuidS = uuid.toString();
  //  uuidS = "008107e5-a7da-4626-b9a3-a911920332ac";
  //  uuid = uuidS as Uuid;

  List<Section> sections = <Section>[];
  List<Section> newSections = <Section>[];
  Section sectionRequest = Section(name: "default");
  Section section = Section(name: "test");

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    sections = (await SectionService().getSection())!;
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  //TODO
  void createData() async {
    section = (await SectionService().createSection(sectionRequest))!;
    //print(section.name);
    sections.add(section);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  Future<void> addSection() async {
    setState(() {
      userPost = _textController.text;
      sectionRequest.name = userPost;
      //print(sectionRequest.name);
      createData();
      for (var section in sections) {
        print(section.name);
        newSections.add(section);
      }
      sections = newSections;
      getData();
      notClicked = false;
    });
  }

  Future<void> textFieldShow() async {
    setState(() {
      notClicked = true;
    });
  }

  void slide() {
    print("Slide");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              //decoration: const BoxDecoration(
              //  border: Border(
              //    left: BorderSide(color: Colors.black, width: 2.5),
              //    right: BorderSide(color: Colors.black, width: 2.5),
              //  ),
              //),
              child: Center(
                child: Column(
                  children: <Widget>[
                    sections.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 10, right: 20, bottom: 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 110,
                                  child: Slidable(
                                    // ignore: sort_child_properties_last
                                    child: Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 110,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return const ExercisesPage();
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            sections[index].name,
                                            style:
                                                const TextStyle(fontSize: 70),
                                          ),
                                        ),
                                      ),
                                    ),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) => slide(),
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete_sharp,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Container(
                                  //  height: 110,
                                  //  width: 55,
                                  //  margin: const EdgeInsets.only(
                                  //        left: 0, top: 10, right: 10, bottom: 0),
                                  //  child: ElevatedButton(
                                  //  onPressed: () {},
                                  //  child: const Icon(
                                  //    Icons.settings,
                                  //    color: Colors.white,
                                  //    ),
                                  //  ),
                                  //),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 0,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 0, right: 20, bottom: 0),
                                    width: double.infinity,
                                    height: 110,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
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
              ),
            );
          },
          itemCount: sections.length,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin:
                const EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 10),
            //decoration: BoxDecoration(
            //  shape: BoxShape.circle,
            //  border: Border.all(
            //    color: Colors.black,
            //    width: 2.5
            //  )
            //),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: textFieldShow,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Visibility(
          visible: notClicked,
          child: Container(
            margin:
                const EdgeInsets.only(left: 0, right: 0, top: 21, bottom: 5),
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
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
        ),
      ],
    );
  }
  //TODO Add showing up the new sections
  //TODO Figure out how to overlay list with a widget with section's properties
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