import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import '../model/exercise.dart';
import '../constants.dart';

part 'exercise_provider.g.dart';

@riverpod
class Exercises extends _$Exercises {
  @override
  Future<List<Exercise>> build(String sectionId, String userId) async {
    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.exerciseEndpoint +
        "/${userId}" +
        "/${sectionId}");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Exercise> exercises = exerciseFromJsonList(response.body);
      return exercises;
    } else {
      return [];
    }
  }

  Future<void> createExercise(Exercise exercise) async {
    await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.exerciseEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(exercise.toJson()),
    );

    ref.invalidateSelf();

    await future;
  }

  Future<void> deleteExerciseSingle(String id) async {
    await http.delete(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.exerciseSingleEndpoint +
          "/${id}"),
    );

    ref.invalidateSelf();

    await future;
  }

  Future<void> deleteExerciseList(String id) async {
    await http.delete(
      Uri.parse(
          ApiConstants.baseUrl + ApiConstants.exerciseListEndpoint + "/${id}"),
    );

    ref.invalidateSelf();

    await future;
  }
}
