import 'dart:convert';

class Exercise {
  late String? id;
  late String? sectionId;
  late String? userId;
  late String? name;

  Exercise({
    this.id,
    this.sectionId,
    this.userId,
    this.name,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "userId": userId,
        "name": name
      };

  static Exercise fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"] as String,
        sectionId: json["sectionId"] as String,
        userId: json["userId"] as String,
        name: json["name"] as String,
      );
}

List<Exercise> exerciseFromJsonList(String str) =>
    List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

Map<String, dynamic> exerciseFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String exerciseToJson(Exercise exercise) => json.encode(exercise.toJson());
