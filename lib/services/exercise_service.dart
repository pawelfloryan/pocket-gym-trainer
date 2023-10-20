import 'dart:convert';
import 'dart:developer';

import 'package:PocketGymTrainer/components/prepared_exercise.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../model/exercise.dart';
import '../model/prepared_exercise.dart';

class ExerciseService {
  Future<Exercise> createExercise(Exercise exercise) async {
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
    } else {
      Exercise empty = Exercise();
      return empty;
    }
  }

  Future<List<Exercise>> getAllExercises(String userId) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exerciseEndpoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Exercise> exercisesTemp = exerciseFromJsonList(response.body);
      List<Exercise> exercises = <Exercise>[];
      for (Exercise exercise in exercisesTemp) {
        if (exercise.userId == userId) {
          exercises.add(exercise);
        }
      }
      return exercises;
    } else {
      List<Exercise> exercises = <Exercise>[];
      return exercises;
    }
  }

  Future<List<Exercise>> getNoSectionExercise(String userId) async {
    var url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.exerciseEndpoint + "/${userId}");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Exercise> exercisesTemp = exerciseFromJsonList(response.body);
      List<Exercise> exercises = <Exercise>[];
      for (Exercise exercise in exercisesTemp) {
        if (exercise.userId == userId) {
          exercises.add(exercise);
        }
      }
      return exercises;
    } else {
      List<Exercise> exercises = <Exercise>[];
      return exercises;
    }
  }

  Future<List<Exercise>> getExercise(String sectionId, String userId) async {
    var url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.exerciseEndpoint + "/${userId}");
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

  Future<List<PreparedExercise>> getPreparedExerciseList(int position) async {
    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.preparedExerciseEndpoint +
        "?position=${position}");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<PreparedExercise> preparedExercises =
          preparedExerciseFromJsonList(response.body);
      return preparedExercises;
    } else {
      List<PreparedExercise> preparedExercises = <PreparedExercise>[];
      return preparedExercises;
    }
  }

  Future<List<Exercise>?> deleteExerciseSingle(String id) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.exerciseSingleEndpoint +
          "/${id}");
      var response = await http.delete(url);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Exercise>?> deleteExerciseList(String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.exerciseListEndpoint + "/${id}");
      var response = await http.delete(url);
    } catch (e) {
      log(e.toString());
    }
  }
}
