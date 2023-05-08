import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gymbro/constants.dart';
import 'package:gymbro/model/section.dart';

class SectionService {
  Future<List<Section>?> createSection() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectionEndpoint);
      var response = await http.post(url);

      //TODO Problems with method referencing
      //var json = Section.toJson(response.body);

      if (response.statusCode == 201) {
        List<Section> sections = sectionFromJson(response.body);
        return sections;
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
        List<Section> sections = sectionFromJson(response.body);
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
        List<Section> _model = sectionFromJson(response.body);
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
        List<Section> _model = sectionFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
