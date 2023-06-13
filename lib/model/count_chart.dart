import 'dart:convert';

class CountChart {
  late int? id;
  late String? sectionId;
  late String? name;

  CountChart({
    this.id,
    this.sectionId,
    this.name,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "name": name
      };

  static CountChart fromJson(Map<String, dynamic> json) => CountChart(
        id: json["id"] as int,
        sectionId: json["sectionId"] as String,
        name: json["name"] as String,
      );
}

List<CountChart> countChartFromJsonList(String str) =>
    List<CountChart>.from(json.decode(str).map((x) => CountChart.fromJson(x)));

Map<String, dynamic> countChartFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String countChartToJson(CountChart countChart) => json.encode(countChart.toJson());
