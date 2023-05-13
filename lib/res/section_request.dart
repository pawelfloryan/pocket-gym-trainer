import 'dart:convert';

class SectionRequest {
  late String? name;

  SectionRequest({
    this.name,
  });

  Map<String, Object?> toJson() => {
        "name": name,
      };

  static SectionRequest fromJsonList(Map<String, dynamic> json) => SectionRequest(
        name: json["name"] as String,
      );

  static SectionRequest fromJson(dynamic json) => SectionRequest(
        name: json["name"] as String,
      );
}

List<SectionRequest> sectionRequestFromJsonList(String str) =>
    List<SectionRequest>.from(json.decode(str).map((x) => SectionRequest.fromJsonList(x)));

SectionRequest sectionRequestFromJson(String str) =>
    json.decode((SectionRequest.fromJson(str)).toString());

String sectionRequestToJson(SectionRequest sectionRequest) =>
    json.encode(sectionRequest.toJson());
