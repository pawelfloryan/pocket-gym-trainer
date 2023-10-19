import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../components/prepared_exercise.dart';
import '../main.dart';
import '../model/prepared_exercise.dart';
import '../services/exercise_service.dart';

class PreparedListPage extends StatefulWidget {
  static List<PreparedExercise> preparedExercises = <PreparedExercise>[];
  static late ItemScrollController itemScrollController =
      ItemScrollController();

  @override
  State<PreparedListPage> createState() => _PreparedListPageState();
}

class _PreparedListPageState extends State<PreparedListPage> {
  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  Future<List<PreparedExercise>>? preparedExercisesData;

  @override
  void initState() {
    super.initState();
    getExercises();
  }

  void getExercises() async {
    PreparedListPage.preparedExercises =
        (await ExerciseService().getPreparedExerciseList(0));
    preparedExercisesData = ExerciseService().getPreparedExerciseList(0);
    print(preparedExercisesData);
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
              return ScrollablePositionedList.builder(
                itemScrollController: PreparedListPage.itemScrollController,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 195,
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 5),
                        child: PreparedExerciseComponent(
                          preparedExercises: PreparedListPage.preparedExercises,
                          certainIndex: index,
                        ),
                      )
                    ],
                  );
                },
                itemCount: 25,
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
        ));
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
