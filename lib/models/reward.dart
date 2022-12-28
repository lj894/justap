import 'dart:convert';

List<Reward> rewardFromJson(String str) =>
    List<Reward>.from(json.decode(str).map((x) => Reward.fromJson(x)));

String rewardToJson(List<Reward> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reward {
  Reward(
      {this.businessId,
      this.businessRewardId,
      this.businessName,
      this.businessRewardName,
      this.type,
      this.businessProfileUrl,
      this.totalPoints,
      this.redeemPoints,
      this.createdAt,
      this.businessRewardExpiredAt,
      this.countDownDays,
      this.isExpired});
  int? businessId;
  int? businessRewardId;
  String? businessName;
  String? businessRewardName;
  String? type;
  String? businessProfileUrl;
  int? totalPoints;
  int? redeemPoints;
  int? createdAt;
  int? businessRewardExpiredAt;
  int? countDownDays;
  bool? isExpired;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
      businessId: json["businessId"],
      businessRewardId: json["businessRewardId"],
      businessName: json["businessName"],
      businessRewardName: json["businessRewardName"],
      type: json["type"],
      businessProfileUrl: json["businessProfileUrl"],
      totalPoints: json["totalPoints"],
      redeemPoints: json["redeemPoints"],
      createdAt: json["createdAt"],
      businessRewardExpiredAt: json["businessRewardExpiredAt"],
      countDownDays: json["countDownDays"],
      isExpired: json["isExpired"]);

  Map<String, dynamic> toJson() => {
        "businessId": businessId,
        "businessRewardId": businessRewardId,
        "businessName": businessName,
        "businessRewardName": businessRewardName,
        "type": type,
        "businessProfileUrl": businessProfileUrl,
        "totalPoints": totalPoints,
        "redeemPoints": redeemPoints,
        "createdAt": createdAt,
        "businessRewardExpiredAt": businessRewardExpiredAt,
        "countDownDays": countDownDays,
        "isExpired": isExpired
      };
}
