import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/page/exercises_page.dart';
import 'package:gymbro/model/section.dart';
import 'package:gymbro/page/login_page.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import 'package:gymbro/services/section_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});
  static late var sectionKey;
  static late var sectionName;

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  bool isLoading = false;
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = false;
  double click = 1;
  double temp = 1;

  List<Section> sections = <Section>[];
  List<Section> newSections = <Section>[];
  List<Section> newSectionsDelete = <Section>[];
  Section sectionCreate = Section();
  Section section = Section();
  Section sectionDelete = Section();
  String sectionId = "";

  String jwtToken = LoginPage.token;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    sections = (await SectionService().getSection(jwtToken));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void createData() async {
    section = (await SectionService().createSection(sectionCreate, jwtToken))!;
    sections.add(section);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void deleteData(String sectionId) async {
    await SectionService().deleteSection(sectionId, jwtToken);
    getData();
    sectionDelete.id = sectionId;
    newSectionsDelete = sections;
    newSectionsDelete.remove(sectionDelete);
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  Future<void> addSection() async {
    setState(() {
      userPost = _textController.text;
      sectionCreate.name = userPost;
      createData();
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      notClicked = false;
      _textController.text = "";
      click -= 1;
    });
  }

  void deleteSection(String id) {
    setState(() {
      sectionId = id;
      deleteData(sectionId);
      sections = newSectionsDelete;
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
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (context, index) {
            return Container(
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
                                    child: Container(
                                      width: double.infinity,
                                      height: 110,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black),
                                        onPressed: () {
                                          SectionPage.sectionKey =
                                              sections[index].id;
                                          SectionPage.sectionName = 
                                              sections[index].name;
                                          context.go('/exercises');
                                        },
                                        child: Text(
                                          sections[index].name!,
                                          style: const TextStyle(fontSize: 70),
                                        ),
                                      ),
                                    ),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) => deleteSection(
                                              sections[index].id!),
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
                          onPressed: addSection,
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
    );
  }
}
