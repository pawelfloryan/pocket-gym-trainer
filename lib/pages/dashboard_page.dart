import 'package:go_router/go_router.dart';

import '../components/workout_timer.dart';
import '../main.dart';
import '../pages/display_exercises_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';
import '../pages/section_page.dart';
import '../pages/stats_page.dart';
import '../components/sidebar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static late bool workoutStart = false;
  static int currentPage = 0;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> pages = const [HomePage(), DisplayExercisesPage(), StatsPage()];
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  void getSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    RootPage.toolTipsOn = prefs.getBool('toolTips') ?? true;
  }

  void showSidebar() {
    setState(() {
      _key.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              showSidebar();
            },
            icon: Icon(Icons.menu),
          ),
          title: DashboardPage.currentPage == 0
              ? const Text("Home")
              : DashboardPage.currentPage == 1
                  ? const Text("Exercises")
                  : const Text("Statistics"),
          actions: [WorkoutTimer()],
        ),
        key: _key,
        body: pages[DashboardPage.currentPage],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.sports_gymnastics), label: 'Exercises'),
            NavigationDestination(
                icon: Icon(Icons.info_outline), label: 'Statistics'),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              DashboardPage.currentPage = index;
            });
            print(GoRouter.of(context).location);
          },
          selectedIndex: DashboardPage.currentPage,
        ),
        drawer: Sidebar());
  }
}
