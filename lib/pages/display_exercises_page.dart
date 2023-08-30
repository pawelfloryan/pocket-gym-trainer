import 'package:PocketGymTrainer/pages/no_section_page.dart';
import 'package:PocketGymTrainer/pages/section_page.dart';
import 'package:PocketGymTrainer/pages/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DisplayExercisesPage extends StatelessWidget {
  const DisplayExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
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
              children: [
                SectionPage(),
                NoSectionPage()
              ],
            ),
          )
        ],
      ),
    );
  }
}