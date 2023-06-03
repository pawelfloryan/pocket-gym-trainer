import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:gymbro/constants.dart';
import 'package:gymbro/model/login.dart';
import 'package:gymbro/model/register.dart';
import '../model/auth_result.dart';

class AuthService{
  Future<AuthResult> loginAction(Login login) async {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);
      var loginJson = login.toJson();
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(loginJson));

        Map<String, dynamic> jsonMap = json.decode(response.body);
        AuthResult authResult = AuthResult.fromJson(jsonMap);
        return authResult;
  }

  Future<AuthResult> registerAction(Register register) async {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpoint);
      var registerJson = register.toJson();
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(registerJson));

        Map<String, dynamic> jsonMap = json.decode(response.body);
        AuthResult authResult = AuthResult.fromJson(jsonMap);
        return authResult;
  }
}