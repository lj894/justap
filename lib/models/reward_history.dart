import 'dart:convert';

List<RewardHistory> rewardHistoryFromJson(String str) =>
    List<RewardHistory>.from(
        json.decode(str).map((x) => RewardHistory.fromJson(x)));

String rewardHistoryToJson(List<RewardHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardHistory {
  RewardHistory(
      {this.businessRewardId,
      this.store,
      this.businessRewardName,
      this.type,
      this.image,
      this.points,
      this.createdAt,
      this.businessRewardExpiredAt});

  int? businessRewardId;
  String? store;
  String? businessRewardName;
  String? type;
  String? image;
  int? points;
  int? createdAt;
  int? businessRewardExpiredAt;

  factory RewardHistory.fromJson(Map<String, dynamic> json) => RewardHistory(
        businessRewardId: json["businessRewardId"],
        store: json["store"],
        businessRewardName: json["businessRewardName"],
        type: json["type"],
        image: json["image"],
        points: json["points"],
        createdAt: json["createdAt"],
        businessRewardExpiredAt: json["businessRewardExpiredAt"],
      );

  Map<String, dynamic> toJson() => {
        "businessRewardId": businessRewardId,
        "store": store,
        "businessRewardName": businessRewardName,
        "type": type,
        "image": image,
        "points": points,
        "createdAt": createdAt,
        "businessRewardExpiredAt": businessRewardExpiredAt,
      };
}
