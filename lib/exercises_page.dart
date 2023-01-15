import 'package:flutter/material.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> newExercises = List.generate(_count, (int i) => NewExercise());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chest exercises"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: newExercises,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewExercise,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewExercise() {
    setState(() {
      _count = _count + 1;
      debugPrint("New Exercise $_count");
    });
  }
}

class NewExercise extends StatefulWidget {
  const NewExercise({super.key});

  @override
  State<StatefulWidget> createState() => _NewExercise();
}

class _NewExercise extends State<NewExercise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      decoration: const BoxDecoration(
          color: Colors.grey,
          border: Border(
              top: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
              left: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey))),
    );
  }

  /*Widget newExerciseWidget() => Container(
        color: Colors.black,
        width: double.infinity,
        height: 100,
      );*/
}
