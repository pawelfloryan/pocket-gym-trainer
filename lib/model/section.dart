import 'dart:convert';

class Section {
  late String? id;
  late String? name;
  late String? userId;
  late int? exercisesPerformed;

  Section({
    this.id,
    this.name,
    this.userId,
    this.exercisesPerformed
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
        "userId": userId,
        "exercisesPerformed": exercisesPerformed,
      };

  static Section fromJsonList(Map<String, dynamic> json) => Section(
        id: json["id"] as String,
        name: json["name"] as String,
        userId: json["userId"] as String,
        exercisesPerformed: json["exercisesPerformed"] as int,
      );

  static Section fromJson(Map<String, dynamic> json) => Section(
        id: json["id"] as String,
        name: json["name"] as String,
        userId: json["userId"] as String,
        exercisesPerformed: json["exercisesPerformed"] as int,
      );
}

List<Section> sectionFromJsonList(String str) =>
    List<Section>.from(json.decode(str).map((x) => Section.fromJsonList(x)));

Map<String, dynamic> sectionFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String sectionToJson(Section section) => json.encode(section.toJson());
