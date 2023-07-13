import 'dart:convert';

class UserStats{
  late String? id;
  late int? entries;

  UserStats({
    this.id,
    this.entries,
  });

  Map<String, Object?> toJson() => {
        "id": id,
        "entries": entries,
      };

  static UserStats fromJson(Map<String, dynamic> json) => UserStats(
        id: json["id"] as String,
        entries: json["entries"] as int,
      );
}

List<UserStats> userStatsFromJsonList(String str) =>
    List<UserStats>.from(json.decode(str).map((x) => UserStats.fromJson(x)));

Map<String, dynamic> userStatsFromJson(String str) {
  Map<String, dynamic> jsonMap = json.decode(str);
  return jsonMap;
}

String userStatsToJson(UserStats userStats) => json.encode(userStats.toJson());