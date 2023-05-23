import 'dart:convert';

class Exercise {
  late String? id;
  late String? sectionId;
  late String? image;
  late String? name;
  late List<dynamic>? description;

  Exercise({
    this.id,
    this.sectionId,
    this.image,
    this.name,
    this.description,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "image": image,
        "name": name,
        "description": description
      };

  static Exercise fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"] as String,
        sectionId: json["sectionId"] as String,
        image: json["image"] as String,
        name: json["name"] as String,
        description: json["description"] as List<dynamic>,
      );
}

List<Exercise> exerciseFromJsonList(String str) =>
    List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

Map<String, dynamic> exerciseFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String exerciseToJson(Exercise exercise) => json.encode(exercise.toJson());
