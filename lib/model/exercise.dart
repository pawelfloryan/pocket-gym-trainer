final String exerciseTable = 'exercise';

class ExerciseFields {
  static final List<String> values = [
    id,
    title,
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String image = 'image';
}

class Exercise {
  final int? id;
  final String title;
  final String image;

  Exercise({
    this.id,
    required this.title,
    required this.image,
  });

  Map<String, Object?> toJson() => {
        ExerciseFields.id: id,
        ExerciseFields.title: title,
        ExerciseFields.image: image,
      };

  static Exercise fromJson(Map<String, Object?> json) => Exercise(
        id: json[ExerciseFields.id] as int?,
        title: json[ExerciseFields.title] as String,
        image: json[ExerciseFields.image] as String,
      );

  Exercise copy({
    int? id,
    String? title,
    String? image,
  }) =>
      Exercise(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
      );
}
