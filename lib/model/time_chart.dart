import 'dart:convert';

class TimeChart {
  late int? id;
  late String? time;
  late int? daysAmount;

  TimeChart({
    this.id,
    this.time,
    this.daysAmount,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "time": time,
        "daysAmount": daysAmount
      };

  static TimeChart fromJson(Map<String, dynamic> json) => TimeChart(
        id: json["id"] as int,
        time: json["time"] as String,
        daysAmount: json["daysAmount"] as int,
      );
}

List<TimeChart> timeChartFromJsonList(String str) =>
    List<TimeChart>.from(json.decode(str).map((x) => TimeChart.fromJson(x)));

Map<String, dynamic> timeChartFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String timeChartToJson(TimeChart timeChart) => json.encode(timeChart.toJson());
