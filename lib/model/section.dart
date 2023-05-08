import 'dart:convert';

class Section {
  final String id;
  final String name;

  Section({
    required this.id,
    required this.name,
  });

  Map<String, Object?> toJson(String str) => {
        "id": id,
        "name": name,
      };

  static Section fromJson(Map<String, dynamic> json) => Section(
        id: json["id"] as String,
        name: json["name"] as String,
      );

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

List<Section> sectionFromJson(String str) =>
    List<Section>.from(json.decode(str).map((x) => Section.fromJson(x)));
