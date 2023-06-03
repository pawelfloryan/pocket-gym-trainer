import 'dart:convert';

class Register {
  late String? name;
  late String? email;
  late String? password;

  Register({
    this.name,
    this.email,
    this.password,
  });

  Map<String, Object?> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };

  static Register fromJson(Map<String, dynamic> json) => Register(
        name: json["name"] as String,
        email: json["email"] as String,
        password: json["password"] as String,
      );
}

List<Register> registerFromJsonList(String str) =>
    List<Register>.from(json.decode(str).map((x) => Register.fromJson(x)));

Map<String, dynamic> registerFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String registerToJson(Register register) => json.encode(register.toJson());
