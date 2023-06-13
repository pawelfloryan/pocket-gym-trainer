import 'dart:convert';

class TimeChart {
  late int? id;
  late String? sectionId;
  late String? name;

  TimeChart({
    this.id,
    this.sectionId,
    this.name,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "sectionId": sectionId,
        "name": name
      };

  static TimeChart fromJson(Map<String, dynamic> json) => TimeChart(
        id: json["id"] as int,
        sectionId: json["sectionId"] as String,
        name: json["name"] as String,
      );
}

List<TimeChart> timeChartFromJsonList(String str) =>
    List<TimeChart>.from(json.decode(str).map((x) => TimeChart.fromJson(x)));

Map<String, dynamic> timeChartFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String timeChartToJson(TimeChart timeChart) => json.encode(timeChart.toJson());
