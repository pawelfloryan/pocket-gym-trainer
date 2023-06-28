import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

enum Theme { light, dark, neon, falcon }

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserName = decodedToken["name"];
  late String decodedUserEmail = decodedToken["email"];

  Theme? selectedTheme = Theme.light;

  String stringValue = "";
  
  Future<void> lightTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("lightMode", 0);
    prefs.setString("radioLight", stringValue);
  }
  Future<void> darkTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("darkMode", 1);
    prefs.setString("radioDark", stringValue);
  }
  Future<void> neonTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("neonMode", 2);
    prefs.setString("radioNeon", stringValue);
  }
  Future<void> falconTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("falconMode", 3);
    prefs.setString("radioFalcon", stringValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Settings"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            decodedUserName,
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                        Text(
                          decodedUserEmail,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10, left: 15),
                  child: Text(
                    "Performance settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey[200]!),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
                      child: Text(
                        "Language",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey[200]!),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
                      child: Text(
                        "Tooltips",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10, left: 15),
                  child: Text(
                    "Themes",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey[200]!),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
                      child: Text(
                        "Light",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Radio<Theme>(
                            value: Theme.light,
                            groupValue: selectedTheme,
                            onChanged: (Theme? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              lightTheme();
                              RootPage().getLightPrefs();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey[200]!),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
                      child: Text(
                        "Dark",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Radio<Theme>(
                            value: Theme.dark,
                            groupValue: selectedTheme,
                            onChanged: (Theme? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              darkTheme();
                              RootPage().getDarkPrefs();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey[200]!),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
                      child: Text(
                        "Neon",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Radio<Theme>(
                            value: Theme.neon,
                            groupValue: selectedTheme,
                            onChanged: (Theme? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              neonTheme();
                              RootPage().getNeonPrefs();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey[200]!),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
                      child: Text(
                        "Falcon",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Radio<Theme>(
                            value: Theme.falcon,
                            groupValue: selectedTheme,
                            onChanged: (Theme? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              falconTheme();
                              RootPage().getFalconPrefs();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
