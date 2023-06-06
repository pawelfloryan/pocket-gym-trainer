import 'package:flutter/material.dart';
import 'package:gymbro/page/home_page.dart';
import 'package:gymbro/page/section_page.dart';
import 'package:gymbro/page/stats_page.dart';
import 'package:sidebarx/sidebarx.dart';
import '../components/sidebar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);
  bool _isVisible = true;
  int currentPage = 0;
  List<Widget> pages = const [HomePage(), SectionPage(), StatsPage()];
  void show() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            show();
          },
          icon: Icon(Icons.menu),
        ),
        title: const Text("Dashboard"),
      ),
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
      drawer: SidebarX(
        controller: _sidebarController,
        items: [
          SidebarXItem(icon: Icons.home, label: 'Home'),
          SidebarXItem(icon: Icons.search, label: 'Search'),
        ],
      ),
    );
  }
}
