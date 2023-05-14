import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gymbro/constants.dart';
import 'package:gymbro/model/section.dart';
import 'package:gymbro/res/section_request.dart';

class SectionService {
  Future<Section?> createSection(Section section) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
      var sectionJson = section.toJson();
      var response = await http.post(url, headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',}, body: json.encode(sectionJson));

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        //Section sections = sectionFromJsonList(response.body)[0];
        Section section = Section.fromJson(jsonMap);
        return section;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Section>?> getSection() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<Section> sections = sectionFromJsonList(response.body);
        return sections;
      }
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

  Future<List<Section>?> deleteSection() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        List<Section> _model = sectionFromJsonList(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
