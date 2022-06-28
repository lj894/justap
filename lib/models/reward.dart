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
        store: json["store"] == null ? null : json["store"],
        type: json["type"] == null ? null : json["type"],
        image: json["image"] == null ? null : json["image"],
        credit: json["credit"] == null ? null : json["credit"],
        fullCredit: json["fullCredit"] == null ? null : json["fullCredit"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        expiryAt: json["expiryAt"] == null ? null : json["expiryAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store": store == null ? null : store,
        "type": type == null ? null : type,
        "image": image == null ? null : image,
        "credit": credit == null ? null : credit,
        "fullCredit": fullCredit == null ? null : fullCredit,
        "createdAt": createdAt == null ? null : createdAt,
        "expiryAt": expiryAt == null ? null : expiryAt,
      };
}
