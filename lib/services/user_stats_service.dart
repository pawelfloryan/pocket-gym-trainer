import 'dart:convert';
import 'dart:developer';

import '../constants.dart';
import '../model/user_stats.dart';
import 'package:http/http.dart' as http;

class UserStatsService{
  Future<UserStats?> createUserStats(UserStats userStats) async{
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userStatsEndpoint);
      var userStatsJson = userStats.toJson();
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(userStatsJson));

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        UserStats userStats = UserStats.fromJson(jsonMap);
        return userStats;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserStats> getUserStats(String result, String userId) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userStatsEndpoint + "/${userId}");
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + result,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> userStatsMap = userStatsFromJson(response.body);
      UserStats userStats = UserStats();
      userStats = UserStats.fromJson(userStatsMap);
      return userStats;
    } else {
      UserStats userStats = UserStats();
      return userStats;
    }
  }

  Future<UserStats?> upsertUserStats(String id, UserStats userStats) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.userStatsEndpoint + "/${id}");
      var userStatsJson = userStats.toJson();
      var response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(userStatsJson));
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        UserStats userStats = UserStats.fromJson(jsonMap);
        return userStats;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}