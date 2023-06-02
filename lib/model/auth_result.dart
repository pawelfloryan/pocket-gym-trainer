import 'dart:convert';
import 'dart:ffi';

class AuthResult {
  late String? token;
  late bool result;
  late List<dynamic>? errors;

  AuthResult({
    this.token,
    required this.result,
    this.errors,
  });

  Map<String, Object?> toJson() => {
        "token": token,
        "result": result,
        "errors": errors,
      };

  static AuthResult fromJson(Map<String, dynamic> json) => AuthResult(
        token: json["token"] as String?,
        result: json["result"] as bool,
        errors: json["errors"] as List<dynamic>?
      );
}

List<AuthResult> authResultFromJsonList(String str) =>
    List<AuthResult>.from(json.decode(str).map((x) => AuthResult.fromJson(x)));

Map<String, dynamic> authResultFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String authResultToJson(AuthResult authResult) => json.encode(authResult.toJson());
