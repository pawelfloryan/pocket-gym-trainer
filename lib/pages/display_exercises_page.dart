import 'package:PocketGymTrainer/main.dart';
import 'package:PocketGymTrainer/pages/no_section_page.dart';
import 'package:PocketGymTrainer/pages/section_page.dart';
import 'package:PocketGymTrainer/pages/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayExercisesPage extends StatefulWidget {
  const DisplayExercisesPage({super.key});

  @override
  State<DisplayExercisesPage> createState() => _DisplayExercisesPageState();
}

class _DisplayExercisesPageState extends State<DisplayExercisesPage> {
  @override
  void initState() {
    super.initState();
    getDisplay();
    print(RootPage.display);
  }

  void setDisplay(int displayNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('display', displayNumber);
  }

  void getDisplay() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    RootPage.display = prefs.getInt('display') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: RootPage.display,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              setDisplay(value);
              RootPage.display = value;
            },
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  FontAwesomeIcons.rectangleList,
                  color: Colors.grey[900]!,
                ),
                child: Text(
                  "Section tiles",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.subject_outlined,
                  color: Colors.grey[900]!,
                ),
                child: Text(
                  "No tiles",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [SectionPage(), NoSectionPage()],
            ),
          )
        ],
      ),
    );
  }
}
