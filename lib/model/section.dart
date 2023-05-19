import 'dart:convert';

class Section {
  late String? id;
  late String? name;

  Section({
    this.id,
    this.name,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
      };

  static Section fromJsonList(Map<String, dynamic> json) => Section(
        id: json["id"] as String,
        name: json["name"] as String,
      );

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

List<Section> sectionFromJsonList(String str) =>
    List<Section>.from(json.decode(str).map((x) => Section.fromJsonList(x)));

Map<String, dynamic> sectionFromJson(String str){
  //json.decode((Section.fromJson(str)).toString());
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}
String sectionToJson(Section section) =>
    json.encode(section.toJson());
