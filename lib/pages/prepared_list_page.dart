import 'package:PocketGymTrainer/model/exercise.dart';
import 'package:PocketGymTrainer/model/section.dart';
import 'package:PocketGymTrainer/pages/dashboard_page.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';

import '../components/prepared_exercise.dart';
import '../main.dart';
import '../model/prepared_exercise.dart';
import '../services/exercise_service.dart';
import '../services/section_services.dart';

class PreparedListPage extends StatefulWidget {
  static List<PreparedExercise> preparedExercises = <PreparedExercise>[];
  static late ItemScrollController itemScrollController =
      ItemScrollController();

  @override
  State<PreparedListPage> createState() => _PreparedListPageState();
}

class _PreparedListPageState extends State<PreparedListPage> {
  List<Section> sections = <Section>[];
  Exercise exercise = Exercise();
  Exercise exerciseCreate = Exercise();
  var _items = <MultiSelectItem<Section>>[];

  final NumberPaginatorController _paginatorController =
      NumberPaginatorController();

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  Future<List<PreparedExercise>>? preparedExercisesData;
  late int perPageCount = 25;

  @override
  void initState() {
    super.initState();
    getSections();
    preparedExercisesData = ExerciseService().getPreparedExerciseList(0);
    getSuggestions();
  }

  void getSuggestions() async {
    PreparedListPage.preparedExercises = (await ExerciseService()
        .getPreparedExerciseList(
            _paginatorController.currentPage * perPageCount));
  }

  Future<void> getSections() async {
    sections = (await SectionService().getSection(jwtToken!, decodedUserId));
    _items = sections
        .map((section) => MultiSelectItem<Section>(section, section.name!))
        .toList();
    print(sections);
  }

  void addExercise() async {
    exercise = (await ExerciseService().createExercise(exerciseCreate));
    if (exercise.id == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Container(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: Text(
                  "Close",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            )
          ],
          title: const Text("Too many exercises"),
          content: const Text("Max amount is 15"),
          contentPadding: const EdgeInsets.all(25.0),
        ),
      );
    } else {
      //TODO Hyperlink to the exercise
      final snackbar = AnimatedSnackBar(
        duration: Duration(seconds: 7),
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        builder: ((context) {
          return Container(
            padding:
                const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
            color: Colors.white,
            height: 35,
            width: 263,
            child: Row(
              children: [
                Text('The exercise was added.'),
                TextButton(
                    onPressed: (() {
                      context.pop();
                    }),
                    child: Text("See it here"))
              ],
            ),
          );
        }),
      );
      snackbar.show(context);
    }
  }

  void showMultiSelect(BuildContext context, String name) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: _items,
          initialValue: [],
          height: 200,
          width: 300,
          onSelectionChanged: (p0) {
            setState(() {
              var uuid = new Uuid();
              exerciseCreate.id = uuid.toString();
              exerciseCreate.name = name;
              exerciseCreate.sectionId = p0[0].id;
              exerciseCreate.userId = decodedUserId;
              addExercise();
            });
            context.pop();
          },
          confirmText: Text(""),
          cancelText: Text(""),
          title: Text(
            "Select the section",
            style: TextStyle(fontSize: 20),
          ),
          itemsTextStyle: TextStyle(fontSize: 18),
        );
        //TextButton(onPressed: (() {}), child: Text("Create a new section"))
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Prepared exercises list"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //context.go('/sections');
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<PreparedExercise>>(
        future: preparedExercisesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ScrollablePositionedList.builder(
                itemScrollController: PreparedListPage.itemScrollController,
                itemBuilder: (context, index) {
                  return Container(
                    height: 195,
                    margin: const EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 5),
                    child: PreparedExerciseComponent(
                      preparedExercises: snapshot.data,
                      certainIndex: index,
                      onClicked: () {
                        showMultiSelect(
                            context, snapshot.data?[index].name ?? "");
                      },
                      context: context,
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return Text("No data");
            }
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: Text("Error"),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: NumberPaginator(
        controller: _paginatorController,
        showPrevButton: true,
        numberPages: (270 / perPageCount).ceil(),
        onPageChange: (int index) {
          setState(() {
            int equate = _paginatorController.currentPage * perPageCount;
            preparedExercisesData =
                ExerciseService().getPreparedExerciseList(equate);
            getSuggestions();
          });
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var exercise in PreparedListPage.preparedExercises) {
      if (exercise.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(exercise.name!);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            close(context, null);
            PreparedListPage.itemScrollController.scrollTo(
              index: index,
              duration: Duration(seconds: 1),
            );
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var exercise in PreparedListPage.preparedExercises) {
      if (exercise.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(exercise.name!);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            close(context, null);
            PreparedListPage.itemScrollController.scrollTo(
              index: index,
              duration: Duration(milliseconds: 500),
            );
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
