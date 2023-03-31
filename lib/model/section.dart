final String sectionTable = 'section';

class SectionFields {
  static final List<String> values = [
    id, title
  ]; 

  static final String id = '_id';
  static final String title = 'title';
}

class Section {
  final int? id;
  final String title;

  const Section({
    this.id,
    required this.title,
  });

  Map<String, Object?> toJson() => {
    SectionFields.id: id,
    SectionFields.title: title
  };
  
  static Section fromJson(Map<String, Object?> json) => Section(
    id: json[SectionFields.id] as int?,
    title: json[SectionFields.title] as String
  );

  Section copy({
    int? id,
    String? title
  }) => 
      Section(
        id: id ?? this.id,
        title: title ?? this.title
      );
}