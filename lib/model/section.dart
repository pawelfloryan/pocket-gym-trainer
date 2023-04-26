import 'dart:convert';

final String sectionTable = 'section';

class SectionFields {
  static final List<String> values = [
    id,
    name,
  ];

  static final String id = '_id';
  static final String name = 'name';
}

class Section {
  final int id;
  final String name;

  const Section({
    required this.id,
    required this.name,
  });

  //Map<String, Object?> toJson() => {
  //      SectionFields.id: id,
  //      SectionFields.title: title,
  //    };
//
  static Section fromJson(Map<String, dynamic> json) => Section(
        id: json[SectionFields.id] as int,
        name: json[SectionFields.name] as String,
      );

  static List<Section> sectionFromJson(String str) =>
      List<Section>.from(json.decode(str).map((x) => Section.fromJson(x)));
//
  //Section copy({
  //  int? id,
  //  String? title,
  //}) =>
  //    Section(
  //      id: id ?? this.id,
  //      title: title ?? this.title,
  //    );
}
