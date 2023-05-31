import 'package:flutter/material.dart';
import 'package:gymbro/page/home_page.dart';
import 'package:gymbro/page/section_page.dart';
import 'package:gymbro/page/stats_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    );
  }
}