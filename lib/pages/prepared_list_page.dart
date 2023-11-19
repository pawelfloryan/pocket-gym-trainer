import 'package:PocketGymTrainer/model/exercise.dart';
import 'package:PocketGymTrainer/model/section.dart';
import 'package:PocketGymTrainer/pages/dashboard_page.dart';
import 'package:PocketGymTrainer/providers/prepared_exercise_provider.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/prepared_exercise.dart';
import '../main.dart';
import '../model/prepared_exercise.dart';
import '../services/exercise_service.dart';
import '../services/section_services.dart';

class PreparedListPage extends ConsumerStatefulWidget {
  static List<PreparedExercise> preparedExercises = <PreparedExercise>[];
  static late ItemScrollController itemScrollController =
      ItemScrollController();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreparedListPageState();
}

class _PreparedListPageState extends ConsumerState<PreparedListPage> {
  List<Section> sections = <Section>[];
  Exercise exercise = Exercise();
  Exercise exerciseCreate = Exercise();
  var _items = <MultiSelectItem<Section>>[];

  final NumberPaginatorController _paginatorController =
      NumberPaginatorController();

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  late var position = _paginatorController.currentPage * perPageCount;
  late int perPageCount = 25;

  List<PreparedExercise>? suggestions;

  @override
  void initState() {
    super.initState();
    getSections();
  }

  Future<void> getSections() async {
    sections = (await SectionService().getSection(jwtToken!, decodedUserId));
    _items = sections
        .map((section) => MultiSelectItem<Section>(section, section.name!))
        .toList();
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
    final providedPreparedExercises =
        ref.watch(GetPreparedExerciseListProvider(position));

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
      body: providedPreparedExercises.when(
        data: (preparedExercises) {
          setState(() {
            suggestions = preparedExercises;
            PreparedListPage.preparedExercises = preparedExercises;
          });
          return ScrollablePositionedList.builder(
            itemScrollController: PreparedListPage.itemScrollController,
            itemBuilder: (context, index) {
              return Container(
                height: 195,
                margin: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 5),
                child: PreparedExerciseComponent(
                  preparedExercises: preparedExercises,
                  certainIndex: index,
                  onClicked: () {
                    showMultiSelect(
                        context, preparedExercises[index].name ?? "");
                  },
                  context: context,
                ),
              );
            },
            itemCount: preparedExercises.length,
          );
        },
        error: (error, stackTrace) => Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: Text("Error"),
          ),
        ),
        loading: () => Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
            ),
          ),
        ),
      ),
      bottomNavigationBar: NumberPaginator(
        controller: _paginatorController,
        showPrevButton: true,
        numberPages: (270 / perPageCount).ceil(),
        onPageChange: (int index) {
          setState(() {
            position = _paginatorController.currentPage * perPageCount;
          });
          //providedPreparedExercises = ref.watch(getPreparedExerciseListProvider(
          //    _paginatorController.currentPage * perPageCount));
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

  //This one works
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
              index: PreparedListPage.preparedExercises
                  .indexWhere((exercise) => exercise.name == matchQuery[index]),
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
