import 'package:PocketGymTrainer/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../page/exercises_page.dart';
import '../model/section.dart';
import '../page/login_page.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import '../services/section_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../components/section.dart';

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

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    sections = (await SectionService().getSection(jwtToken!, decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  void createData() async {
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

  Future<void> addSection() async {
    setState(() {
      userPost = _textController.text;
      sectionCreate.name = userPost;
      sectionCreate.userId = decodedUserId;
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

  void editSection() {}

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

    return Stack(
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
                        // ignore: sort_child_properties_last
                        child: Container(
                          width: double.infinity,
                          height: 110,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              SectionPage.sectionKey = sections[index].id;
                              SectionPage.sectionName = sections[index].name;
                              context.push('/exercises');
                            },
                            child: Text(
                              sections[index].name!,
                              style: const TextStyle(fontSize: 70),
                            ),
                          ),
                        ),
                        startActionPane: ActionPane(
                          extentRatio: 0.15,
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => editSection(),
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
                      onPressed: addSection,
                      icon: Icon((Icons.done)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
