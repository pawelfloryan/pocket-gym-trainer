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
class Sections extends _$Sections {
  @override
  Future<List<Section>> build(String result) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + result,
      },
    );
    if (response.statusCode == 200) {
      List<Section> sections = sectionFromJsonList(response.body);
      return sections;
    } else {
      return [];
    }
  }

  Future<void> createSection(Section section) async {
    await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(section.toJson()),
    );

    ref.invalidateSelf();

    await future;
  }

  Future<void> deleteSection(String id, String result) async {
    await http.delete(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint + "/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $result',
      },
    );

    ref.invalidateSelf();

    await future;
  }

  Future<void> upsertSection(String id, Section section) async {
    await http.put(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.sectionEndpoint + "/${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(section.toJson()));

    ref.invalidateSelf();

    await future;
  }
}
