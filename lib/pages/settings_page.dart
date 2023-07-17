import 'package:PocketGymTrainer/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

List<String> themes = ["light", "dark", "neon", "falcon"];

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

  String? selectedTheme;


  @override
  void initState(){
    super.initState();
    selectedTheme = themes[0];
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt("lightMode", 0);
    //prefs.setString("selectedTheme", selectedTheme!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: MyApp.theme == 0 ? Colors.grey[200] : Colors.grey[900],
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
                //color: MyApp.theme == 0 ? Colors.white : Colors.black,
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
                  //color: MyApp.theme == 0 ? Colors.white : Colors.black,
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
                          child: Radio<String>(
                            value: themes[0],
                            groupValue: MyApp.theme == 0 ? themes[0] : themes[1],
                            onChanged: (String? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              ThemeMethods.lightTheme();
                              MyApp().getLightPrefs();
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
                          child: Radio<String>(
                            value: themes[1],
                            groupValue: MyApp.theme == 1 ? themes[1] : themes[0],
                            onChanged: (String? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              ThemeMethods.darkTheme();
                              MyApp().getDarkPrefs();
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
                          child: Radio<String>(
                            value: themes[2],
                            groupValue: MyApp.theme == 2 ? themes[2] : themes[0],
                            onChanged: (String? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              ThemeMethods.neonTheme();
                              MyApp().getNeonPrefs();
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
                          child: Radio<String>(
                            value: themes[3],
                            groupValue: MyApp.theme == 3 ? themes[3] : themes[0],
                            onChanged: (String? value) {
                              setState(() {
                                selectedTheme = value!;
                              });
                              print(selectedTheme);
                              ThemeMethods.falconTheme();
                              MyApp().getFalconPrefs();
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
