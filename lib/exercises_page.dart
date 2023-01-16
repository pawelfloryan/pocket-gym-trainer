import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final _exerciseController = TextEditingController();
  final _weightController = TextEditingController();
  bool exerciseNotClicked = true;
  bool weightNotClicked = true;
  String exerciseUserPost = '';
  String weightUserPost = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Material(
        elevation: 6,
        color: Colors.grey,
        child: Container(
          margin: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 0, top: 0, bottom: 0),
                width: 140,
                height: 115,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white, width: 4),
                    bottom: BorderSide(color: Colors.white, width: 4),
                    left: BorderSide(color: Colors.white, width: 4),
                    right: BorderSide(color: Colors.white, width: 4),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: const Tooltip(
                    message: "Upload your photos here!",
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 70,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 174,
                    height: 40,
                    margin: const EdgeInsets.only(
                        left: 20, right: 0, top: 13, bottom: 20),
                    child: exerciseNotClicked == true ? TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      controller: _exerciseController,
                      decoration: InputDecoration(
                        hintText: 'Exercise Name',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            exerciseUserPost = _exerciseController.text;
                            setState(() {
                              exerciseNotClicked = false;
                            });
                          },
                          icon: Icon((Icons.done)),
                        ),
                      ),
                    ) : Container(
                      margin: const EdgeInsets.only(
                        left: 0, right: 0, top: 5, bottom: 0),
                      child: Text(
                        exerciseUserPost,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 174,
                    height: 40,
                    margin: const EdgeInsets.only(
                        left: 20, right: 0, top: 0, bottom: 0),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      controller: _weightController,
                      decoration: InputDecoration(
                        hintText: 'Kilos/Pounds',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            _weightController.clear();
                          },
                          icon: Icon((Icons.done)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget newExerciseWidget() => Container(
        color: Colors.black,
        width: double.infinity,
        height: 100,
      );*/
}
