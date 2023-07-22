import 'package:PocketGymTrainer/main.dart';
import 'package:PocketGymTrainer/providers/section_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../model/section.dart';
import '../pages/login_page.dart';
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
  final _textController = TextEditingController();
  String userPost = '';
  String sectionName = '';
  bool notClicked = false;
  bool editing = false;
  int selectedSectionIndex = -1;

  String sectionId = "";

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  @override
  void initState() {
    super.initState();
    SectionProvider().getData();
    print(sections);
  }

  Future<void> addSection() async {
    setState(() {
      userPost = _textController.text;
      sectionCreate.name = userPost;
      sectionCreate.userId = decodedUserId;
      SectionProvider().createData();
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      notClicked = false;
      _textController.text = "";
    });
  }

  void deleteSection(String id) {
    setState(() {
      sectionId = id;
      SectionProvider().deleteData(sectionId);
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
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
      SectionProvider().upsertData(sectionId);
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      SectionProvider().getData();
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => setState(() {}));
      sections = newSections;
      _textController.text = "";
    });
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
                                  ? Text(
                                      sections[index].name!,
                                      style: const TextStyle(fontSize: 70),
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
                                              SectionPage.sectionIndex = index;
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
                                      selectedSectionIndex =  index;
                                    }else{
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
                                    : Icons.subdirectory_arrow_left_sharp ,
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
                onPressed: () {
                  setState(() {
                    notClicked = !notClicked;
                  });
                },
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
                  margin: const EdgeInsets.only(
                      left: 7, top: 0, right: 0, bottom: 0),
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
      ),
    );
  }
}
