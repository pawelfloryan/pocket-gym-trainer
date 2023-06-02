import 'dart:convert';

class Login {
  late String? email;
  late String? password;

  Login({
    this.email,
    this.password,
  });

  Map<String, Object?> toJson() => {
        "email": email,
        "password": password,
      };

  static Login fromJson(Map<String, dynamic> json) => Login(
        email: json["email"] as String,
        password: json["password"] as String,
      );
}

List<Login> loginFromJsonList(String str) =>
    List<Login>.from(json.decode(str).map((x) => Login.fromJson(x)));

Map<String, dynamic> loginFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String loginToJson(Login login) => json.encode(login.toJson());
