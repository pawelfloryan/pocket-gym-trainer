import 'dart:convert';

class CountChart {
  late int? id;
  late String? name;
  late String? amount;

  CountChart({
    this.id,
    this.name,
    this.amount,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
        "amount": amount
      };

  static CountChart fromJson(Map<String, dynamic> json) => CountChart(
        id: json["id"] as int,
        name: json["name"] as String,
        amount: json["amount"] as String,
      );
}

List<CountChart> countChartFromJsonList(String str) =>
    List<CountChart>.from(json.decode(str).map((x) => CountChart.fromJson(x)));

Map<String, dynamic> countChartFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String countChartToJson(CountChart countChart) => json.encode(countChart.toJson());
