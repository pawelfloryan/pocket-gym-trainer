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
      body: Center(
        heightFactor: 4.0,
        child: Text(
          "Coming soon",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
