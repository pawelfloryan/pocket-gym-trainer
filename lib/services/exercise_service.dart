import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../constants.dart';
import '../model/exercise.dart';

class ExerciseService {
  Future<Exercise?> createExercise(Exercise exercise) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exerciseEndpoint);
      var exerciseJson = exercise.toJson();
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(exerciseJson));

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        Exercise exercise = Exercise.fromJson(jsonMap);
        return exercise;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Exercise>> getExercise(String sectionId, String userId) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exerciseEndpoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Exercise> exercisesTemp = exerciseFromJsonList(response.body);
      List<Exercise> exercises = <Exercise>[];
      for (Exercise exercise in exercisesTemp) {
        if (exercise.sectionId == sectionId && exercise.userId == userId) {
          exercises.add(exercise);
        }
      }
      return exercises;
    } else {
      List<Exercise> exercises = <Exercise>[];
      return exercises;
    }
  }

  Future<List<Exercise>?> upsertExercise() async {}

  Future<List<Exercise>?> deleteExercise(String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.exerciseEndpoint + "/${id}");
      var response = await http.delete(url);
    } catch (e) {
      log(e.toString());
    }
  }
}
