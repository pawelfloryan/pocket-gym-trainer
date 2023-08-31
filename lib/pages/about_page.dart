import 'package:PocketGymTrainer/components/spinningLogo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse("https://github.com/pawelfloryan/pocket-gym-trainer");

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

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
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 30),
              child: Text(
                "About this app",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 100),
            child: Text(
                "I built it as an open-source project to help people (and myself) reach fitness goals.\nIt aims to digitalize a traditional method of writing the workout plan on a piece of paper.\nI never wanted to do that so here I am writing a whole mobile app for this purpose.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 300,
              margin: EdgeInsets.only(left: 30, top: 30),
              child: Text(
                "I hope that it will help you and thanks for using it!",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => _launchUrl(),
              child: Container(
                margin: EdgeInsets.only(top: 30, left: 40, bottom: 20),
                child: SpinningLogo(
                  child: Icon(
                    FontAwesomeIcons.github,
                    size: 120,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: AboutListTile(
              icon: Icon(Icons.info),
              applicationIcon: Image.asset(
                "images/icon.png",
                scale: 5,
              ),
              applicationName: 'Pocket gym trainer',
              applicationVersion: 'version 0.0.1',
            ),
          )
        ],
      ),
    );
  }
}
