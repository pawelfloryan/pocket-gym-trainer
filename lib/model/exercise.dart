import 'dart:convert';

final String exerciseTable = 'exercise';

class ExerciseFields {
  static final List<String> values = [
    id,
    sectionId,
    image,
    name,
    description,
  ];

  static final String id = '_id';
  static final String sectionId = 'sectionId';
  static final String image = 'image';
  static final String name = 'name';
  static final String description = 'description';
}

class Exercise {
  final int id;
  final int sectionId;
  final String image;
  final String name;
  final String description;

  Exercise({
    required this.id,
    required this.sectionId,
    required this.image,
    required this.name,
    required this.description,
  });

  //Map<String, Object?> toJson() => {
  //      ExerciseFields.id: id,
  //      ExerciseFields.title: title,
  //      ExerciseFields.image: image,
  //    };
//
  static Exercise fromJson(Map<String, Object?> json) => Exercise(
        id: json[ExerciseFields.id] as int,
        sectionId: json[ExerciseFields.sectionId] as int,
        image: json[ExerciseFields.image] as String,
        name: json[ExerciseFields.name] as String,
        description: json[ExerciseFields.description] as String,
      );

  static List<Exercise> exerciseFromJson(String str) =>
      List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));
//
  //Exercise copy({
  //  int? id,
  //  String? title,
  //  String? image,
  //}) =>
  //    Exercise(
  //      id: id ?? this.id,
  //      title: title ?? this.title,
  //      image: image ?? this.image,
  //    );
}
