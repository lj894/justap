import 'dart:convert';

List<RewardLog> rewardLogFromJson(String str) =>
    List<RewardLog>.from(json.decode(str).map((x) => RewardLog.fromJson(x)));

String rewardLogToJson(List<RewardLog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardLog {
  RewardLog({this.id, this.message, this.createdAt});

  int? id;
  String? message;
  int? createdAt;

  factory RewardLog.fromJson(Map<String, dynamic> json) => RewardLog(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "createdAt": createdAt,
      };
}
