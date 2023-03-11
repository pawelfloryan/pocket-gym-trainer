final String exerciseTable = 'section';

class ExerciseFields {
  static final List<String> values = [
    id, title
  ]; 

  static final String id = '_id';
  static final String title = 'title';
}

class Exercise {
  final int? id;
  final String title;

  const Exercise({
    this.id,
    required this.title,
  });

  Map<String, Object?> toJson() => {
    ExerciseFields.id: id,
    ExerciseFields.title: title
  };
  
  static Exercise fromJson(Map<String, Object?> json) => Exercise(
    id: json[ExerciseFields.id] as int?,
    title: json[ExerciseFields.title] as String
  );

  Exercise copy({
    int? id,
    String? title
  }) => 
      Exercise(
        id: id ?? this.id,
        title: title ?? this.title
      );
}