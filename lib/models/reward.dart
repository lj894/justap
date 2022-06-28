import 'dart:convert';

List<Reward> rewardFromJson(String str) =>
    List<Reward>.from(json.decode(str).map((x) => Reward.fromJson(x)));

String rewardToJson(List<Reward> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reward {
  Reward(
      {this.id,
      this.store,
      this.type,
      this.image,
      this.credit,
      this.fullCredit,
      this.createdAt,
      this.expiryAt});

  int? id;
  String? store;
  String? type;
  String? image;
  int? credit;
  int? fullCredit;
  int? createdAt;
  int? expiryAt;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json["id"],
        store: json["store"],
        type: json["type"],
        image: json["image"],
        credit: json["credit"],
        fullCredit: json["fullCredit"],
        createdAt: json["createdAt"],
        expiryAt: json["expiryAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store": store,
        "type": type,
        "image": image,
        "credit": credit,
        "fullCredit": fullCredit,
        "createdAt": createdAt,
        "expiryAt": expiryAt,
      };
}
