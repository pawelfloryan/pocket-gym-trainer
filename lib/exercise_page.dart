import 'package:flutter/material.dart';
import 'package:gymbro/exercises_page.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> newSection = List.generate(_count, (int i) => NewSection());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: newSection,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewSection,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewSection() {
    setState(() {
      _count = _count + 1;
      debugPrint("New Section $_count");
    });
  }
}

class NewSection extends StatefulWidget {
  const NewSection({super.key});

  @override
  State<NewSection> createState() => _NewSection();
}

class _NewSection extends State<NewSection> {
  final _textController = TextEditingController();
  String userPost = '';
  bool notClicked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const ExercisesPage();
              },
            ),
          );
        },
        child: notClicked == true ? Visibility(
          visible: notClicked,
          child: Container(
            margin: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'The name of new section',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        _textController.clear();
                      },
                      icon: Icon((Icons.clear)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900]
                    ),
                    onPressed: () {
                        userPost = _textController.text;
                        setState(() {
                          notClicked = false;
                        });
                        debugPrint("$userPost");
                    }, 
                    child: Text("SUBMIT")
                  ),
                ),
              ],
            ),
          ),
        ) : Text(
          userPost,
          style: TextStyle(fontSize: 70),
          ),
      ),
    );
  }
}
