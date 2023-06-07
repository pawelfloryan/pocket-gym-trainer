import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/page/home_page.dart';
import 'package:gymbro/page/section_page.dart';
import 'package:gymbro/page/stats_page.dart';
import 'package:sidebarx/sidebarx.dart';
import '../components/sidebar.dart';
import '../main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPage = 0;
  List<Widget> pages = const [HomePage(), SectionPage(), StatsPage()];
  final _key = GlobalKey<ScaffoldState>();
  void showSidebar() {
    setState(() {
      //RootPage.logged = false;
      //context.pop();
      _key.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                showSidebar();
              },
              icon: Icon(Icons.menu),
            ),
            title: currentPage == 0
                ? const Text("Home")
                : currentPage == 1
                    ? const Text("Exercises")
                    : const Text("Statistics")),
        key: _key,
        body: pages[currentPage],
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
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
        drawer: Sidebar());
  }
}
