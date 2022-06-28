import 'dart:convert';

List<History> historyFromJson(String str) =>
    List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
  History(
      {this.id, this.nickName, this.profileUrl, this.notes, this.createdAt});

  int? id;
  String? nickName;
  String? profileUrl;
  String? notes;
  int? createdAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
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
