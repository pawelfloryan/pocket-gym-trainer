import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:number_paginator/number_paginator.dart';
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
  final NumberPaginatorController _paginatorController =
      NumberPaginatorController();
  int currentPage = 0;

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  Future<List<PreparedExercise>>? preparedExercisesData;
  late int perPageCount = 25;

  @override
  void initState() {
    super.initState();
    getPreparedExercises();
  }

  void getPreparedExercises() async {
    if (currentPage == 0) {
      preparedExercisesData = ExerciseService().getPreparedExerciseList(0);
    } else {
      preparedExercisesData = ExerciseService().getPreparedExerciseList(
          _paginatorController.currentPage * perPageCount);
    }
    _paginatorController.currentPage = currentPage;
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
                    ),
                  );
                },
                itemCount: perPageCount,
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
            currentPage = index;
            getPreparedExercises();
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
