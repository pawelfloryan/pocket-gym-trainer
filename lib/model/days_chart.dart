import 'dart:convert';

class DaysChart {
  late int? id;
  late int? amount;
  late int? weekDay;

  DaysChart({
    this.id,
    this.amount,
    this.weekDay,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "sectionId": amount,
        "weekDay": weekDay
      };

  static DaysChart fromJson(Map<String, dynamic> json) => DaysChart(
        id: json["id"] as int,
        amount: json["sectionId"] as int,
        weekDay: json["weekDay"] as int,
      );
}

List<DaysChart> daysChartFromJsonList(String str) =>
    List<DaysChart>.from(json.decode(str).map((x) => DaysChart.fromJson(x)));

Map<String, dynamic> daysChartFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String daysChartToJson(DaysChart daysChart) => json.encode(daysChart.toJson());
