import 'dart:convert';

class PreparedExercise {
  late String? id;
  late String? name;
  late String? muscleGroup;
  late String? level;
  late String? p_p;

  PreparedExercise({
    this.id,
    this.name,
    this.muscleGroup,
    this.level,
    this.p_p,
  });

  @override
  String toString() {
    return '{id: ${id}, name: ${name}, muscleGroup: ${muscleGroup}, level: ${level}, p_p: ${p_p}}';
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
        "muscleGroup": muscleGroup,
        "level": level,
        "p_p": p_p,
      };

  static PreparedExercise fromJson(Map<String, dynamic> json) =>
      PreparedExercise(
        id: json["id"] as String,
        name: json["name"] as String,
        muscleGroup: json["muscleGroup"] as String,
        level: json["level"] as String,
        p_p: json["p_p"] as String,
      );
}

List<PreparedExercise> preparedExerciseFromJsonList(String str) =>
    List<PreparedExercise>.from(
        json.decode(str).map((x) => PreparedExercise.fromJson(x)));

Map<String, dynamic> preparedExerciseFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String preparedExerciseToJson(PreparedExercise preparedExercise) =>
    json.encode(preparedExercise.toJson());
