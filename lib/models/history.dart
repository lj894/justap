import 'dart:convert';

List<History> historyFromJson(String str) =>
    List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
  History({this.id, this.notes, this.createdAt});

  int? id;
  String? notes;
  int? createdAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        notes: json["notes"] == null ? null : json["notes"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notes": notes == null ? null : notes,
        "createdAt": createdAt == null ? null : createdAt,
      };
}
