import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gymbro/constants.dart';
import 'package:gymbro/model/exercise.dart';

class ExerciseService
{
  Future<List<Exercise>?> createExercise() async{
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.exerciseEndpoint);
      var response = await http.get(url);
      if(response.statusCode == 200){
        List<Exercise> _model = Exercise.fromJson(response.body);
      }
    }
    catch(e){
      log(e.toString());
    }
  }
}