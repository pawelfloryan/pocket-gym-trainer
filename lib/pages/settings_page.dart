import 'package:PocketGymTrainer/components/theme_setting.dart';

import '../components/setting.dart';
import '../components/workout_counter.dart';
import '../model/user_stats.dart';
import '../services/user_stats_service.dart';
import '../theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_methods.dart';

import '../main.dart';

String? selectedTheme = themes[0];
List<String> themes = ["light", "dark", "neon", "falcon"];

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
  late String decodedUserId = decodedToken["id"];

  UserStats userStats = UserStats();
  UserStats newUserStats = UserStats();
  UserStats userStatsUpsert = UserStats();

  @override
  void initState() {
    super.initState();
    getUserEntries();
  }

  void getUserEntries() async {
    userStats =
        (await UserStatsService().getUserStats(jwtToken!, decodedUserId));
    if (userStats.entries != null) {
      setState(() {
        WorkoutCounter.number.value = userStats.entries!;
      });
    }
    print(decodedUserId);
    print(userStats.entries);
  }

  void upsertUserEntries() async {
    userStats = (await UserStatsService()
        .upsertUserStats(decodedUserId, userStatsUpsert))!;
    getUserEntries();
    newUserStats = userStats;
    newUserStats.entries = userStatsUpsert.entries;
  }

  void editUserEntries() async {
    setState(() {
      userStatsUpsert.entries = WorkoutCounter.number.value;
      userStatsUpsert.id = decodedUserId;
      upsertUserEntries();
      userStats = newUserStats;
    });
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
                    Container(
                      margin: EdgeInsets.only(
                        left: WorkoutCounter.number.value < 100 ? 30 : 20,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "${WorkoutCounter.number.value}",
                              style: WorkoutCounter.number.value < 100
                                  ? const TextStyle(fontSize: 45)
                                  : WorkoutCounter.number.value < 1000
                                      ? const TextStyle(fontSize: 35)
                                      : const TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 7),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      WorkoutCounter.number.value++;
                                      print(WorkoutCounter.number.value);
                                      editUserEntries();
                                    });
                                  },
                                  child: Icon(Icons.add, size: 35),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      WorkoutCounter.number.value--;
                                      print(WorkoutCounter.number.value);
                                      editUserEntries();
                                    });
                                  },
                                  child: Icon(Icons.remove, size: 35),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                    "Performance settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Setting(
                text: settings[0].toString(),
                child: Icon(Icons.arrow_forward_ios),
              ),
              Setting(
                text: settings[1].toString(),
                child: Icon(Icons.arrow_forward_ios),
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
              Setting(
                text: settings[2].toString(),
                child: Radio<String>(
                  value: themes[0],
                  groupValue: selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                    print(themes[0]);
                    print(selectedTheme);
                  },
                ),
              ),
              Setting(
                text: settings[3].toString(),
                child: Radio<String>(
                  value: themes[1],
                  groupValue: selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                    print(themes[1]);
                    print(selectedTheme);
                  },
                ),
              ),
              Setting(
                text: settings[4].toString(),
                child: Radio<String>(
                  value: themes[2],
                  groupValue: selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                    print(themes[2]);
                    print(selectedTheme);
                  },
                ),
              ),
              Setting(
                text: settings[5].toString(),
                child: Radio<String>(
                  value: themes[3],
                  groupValue: selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                    print(themes[3]);
                    print(selectedTheme);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
