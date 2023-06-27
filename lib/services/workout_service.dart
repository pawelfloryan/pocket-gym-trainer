import 'dart:convert';
import 'dart:developer';

import '../constants.dart';
import '../model/workout.dart';
import 'package:http/http.dart' as http;

class WorkoutService{
  Future<Workout?> createWorkout(Workout workout) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.workoutEndpoint);
      var workoutJson = workout.toJson();
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(workoutJson));

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        Workout workout = Workout.fromJson(jsonMap);
        return workout;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Workout>> getWorkout(String result, String userId) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.workoutEndpoint);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + result,
      },
    );

    if (response.statusCode == 200) {
      List<Workout> workoutsTemp = workoutFromJsonList(response.body);
      List<Workout> workouts = <Workout>[];
      for (Workout workout in workoutsTemp) {
        if (workout.userId == userId) {
          workouts.add(workout);
        }
      }
      return workouts;
    } else {
      List<Workout> workouts = <Workout>[];
      return workouts;
    }
  }
}