import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("About"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //context.go('/sections');
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Text(
            "About the project",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "I built this app as an open-source project to help people (and myself) reach fitness goals.\nIt digitalizes a traditional method of writing the workout plan on a piece of paper.\nI never wanted to do that so here I am writing a whole mobile app for this sole purpose.\n",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
