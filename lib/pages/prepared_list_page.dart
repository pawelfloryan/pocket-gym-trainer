import 'package:PocketGymTrainer/components/exercise.dart';
import 'package:PocketGymTrainer/components/prepared_exercise.dart';
import 'package:PocketGymTrainer/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../main.dart';
import '../services/exercise_service.dart';

class PreparedListPage extends StatefulWidget {
  static List<Exercise> exercises = <Exercise>[];
  static late ItemScrollController itemScrollController =
      ItemScrollController();

  @override
  State<PreparedListPage> createState() => _PreparedListPageState();
}

class _PreparedListPageState extends State<PreparedListPage> {
  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  @override
  void initState() {
    super.initState();
    getExercises();
  }

  void getExercises() async {
    PreparedListPage.exercises = (await ExerciseService()
        .getExercise("e16fc64e-04e6-4676-8324-63b730658b26", decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
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
      body: ScrollablePositionedList.builder(
        itemScrollController: PreparedListPage.itemScrollController,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 195,
                margin: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 5),
                child: PreparedExercise(
                  exercises: PreparedListPage.exercises,
                  certainIndex: index,
                ),
              )
            ],
          );
        },
        itemCount: PreparedListPage.exercises.length,
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
    for (var exercise in PreparedListPage.exercises) {
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
    for (var exercise in PreparedListPage.exercises) {
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
