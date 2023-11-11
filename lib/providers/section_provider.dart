import 'dart:convert';

import 'package:PocketGymTrainer/constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../main.dart';
import '../model/section.dart';
import '../pages/section_page.dart';
import 'package:http/http.dart' as http;

part 'section_provider.g.dart';

@riverpod
Future<List<Section>> getSectionList(
  GetSectionListRef ref,
  String result,
) async {
  var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
  var response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + result,
    },
  );
  //List<Section> sections = sectionFromJsonList(response.body);
  List<Section> sections = [Section(id: "aaaaa", name: "exec")];
  return sections;
}
