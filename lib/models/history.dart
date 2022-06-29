import 'dart:convert';

List<TabHistory> historyFromJson(String str) =>
    List<TabHistory>.from(json.decode(str).map((x) => TabHistory.fromJson(x)));

String historyToJson(List<TabHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TabHistory {
  TabHistory(
      {this.id, this.nickName, this.profileUrl, this.notes, this.createdAt});

  int? id;
  String? nickName;
  String? profileUrl;
  String? notes;
  int? createdAt;

  factory TabHistory.fromJson(Map<String, dynamic> json) => TabHistory(
        id: json["id"],
        nickName: json["nickName"],
        profileUrl: json["profileUrl"],
        notes: json["notes"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickName": nickName,
        "profileUrl": profileUrl,
        "notes": notes,
        "createdAt": createdAt,
      };
}
