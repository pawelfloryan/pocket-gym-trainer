import 'dart:convert';
import 'dart:developer';

import '../model/auth_result.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../model/section.dart';
import '../services/auth_service.dart';

class SectionService {
  Future<Section?> createSection(Section section) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
      var sectionJson = section.toJson();
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(sectionJson));

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        Section section = Section.fromJson(jsonMap);
        return section;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Section>> getSection(String result, String userId) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + result,
      },
    );

    if (response.statusCode == 200) {
      List<Section> sectionsTemp = sectionFromJsonList(response.body);
      List<Section> sections = <Section>[];
      for (Section section in sectionsTemp) {
        if (section.userId == userId) {
          sections.add(section);
        }
      }
      return sections;
    } else {
      List<Section> sections = <Section>[];
      return sections;
    }
  }

  Future<List<Section>?> deleteSection(String id, String result) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.sectionEndpoint + "/${id}");
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $result',
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Section>?> upsertSection() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
      var response = await http.put(url);
      if (response.statusCode == 200) {
        List<Section> _model = sectionFromJsonList(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
