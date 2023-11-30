import 'dart:convert';

import '../model/auth_result.dart';
import '../model/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../model/register.dart';

part 'auth_provider.g.dart';

@riverpod
Future<AuthResult> loginAction(LoginActionRef ref, Login login) async {
  final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(login.toJson()));

  Map<String, dynamic> jsonMap = json.decode(response.body);
  AuthResult authResult = AuthResult.fromJson(jsonMap);
  return authResult;
}

@riverpod
Future<AuthResult> registerAction(RegisterActionRef ref, Register login) async {
  final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(login.toJson()));

  Map<String, dynamic> jsonMap = json.decode(response.body);
  AuthResult authResult = AuthResult.fromJson(jsonMap);
  return authResult;
}
