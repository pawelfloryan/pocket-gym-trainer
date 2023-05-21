import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gymbro/constants.dart';
import 'package:gymbro/model/exercise.dart';

class ExerciseService {
  Future<List<Exercise>?> createExercise() async {}

  Future<List<Exercise>> getExercise() async {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exerciseEndpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<Exercise> exercises = exerciseFromJsonList(response.body);
        return exercises;
      }else{
        List<Exercise> exercises = <Exercise>[];
        return exercises;
      }
  }

  Future<List<Exercise>?> upsertExercise() async {}

  Future<List<Exercise>?> deleteExercise() async {}
}
