import 'package:PocketGymTrainer/components/theme_setting.dart';

import '../components/setting.dart';
import '../theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

List<String> settings = [
  "Language",
  "Tooltips",
  "Light",
  "Dark",
  "Neon",
  "Falcon"
];

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserName = decodedToken["name"];
  late String decodedUserEmail = decodedToken["email"];

  @override
  void initState() {
    super.initState();
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
              Setting(text: settings[0].toString()),
              Setting(text: settings[1].toString()),
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
              ThemeSetting(
                text: settings[2].toString(),
                themeNumber: 0,
                onThemeChanged: ThemeMethods.lightTheme(),
                getThemePrefs: MyApp().getLightPrefs(),
              ),
              ThemeSetting(
                text: settings[3].toString(),
                themeNumber: 1,
                onThemeChanged: ThemeMethods.darkTheme(),
                getThemePrefs: MyApp().getDarkPrefs(),
              ),
              ThemeSetting(
                text: settings[4].toString(),
                themeNumber: 2,
                onThemeChanged: ThemeMethods.neonTheme(),
                getThemePrefs: MyApp().getNeonPrefs(),
              ),
              ThemeSetting(
                text: settings[5].toString(),
                themeNumber: 3,
                onThemeChanged: ThemeMethods.falconTheme(),
                getThemePrefs: MyApp().getFalconPrefs(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
