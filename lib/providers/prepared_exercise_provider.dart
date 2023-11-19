import 'dart:convert';
import '../model/prepared_exercise.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';

part 'prepared_exercise_provider.g.dart';

@riverpod
Future<List<PreparedExercise>> getPreparedExerciseList(
    GetPreparedExerciseListRef ref, int position) async {
  final response = await http.get(
    Uri.parse(ApiConstants.baseUrl +
        ApiConstants.preparedExerciseEndpoint +
        "?position=${position}"),
  );
  if (response.statusCode == 200) {
    List<PreparedExercise> preparedExercises =
        preparedExerciseFromJsonList(response.body);
    return preparedExercises;
  } else {
    List<PreparedExercise> preparedExercises = <PreparedExercise>[];
    return preparedExercises;
  }
}
