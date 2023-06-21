import 'dart:convert';

class Section {
  late String? id;
  late String? name;
  late String? userId;

  Section({
    this.id,
    this.name,
    this.userId,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
        "userId": userId,
      };

  static Section fromJsonList(Map<String, dynamic> json) => Section(
        id: json["id"] as String,
        name: json["name"] as String,
        userId: json["userId"] as String,
      );

  static Section fromJson(Map<String, dynamic> json) => Section(
        id: json["id"] as String,
        name: json["name"] as String,
        userId: json["userId"] as String,
      );
}

List<Section> sectionFromJsonList(String str) =>
    List<Section>.from(json.decode(str).map((x) => Section.fromJsonList(x)));

Map<String, dynamic> sectionFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String sectionToJson(Section section) => json.encode(section.toJson());
