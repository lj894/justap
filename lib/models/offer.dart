import 'dart:convert';

List<Offer> offerFromJson(String str) =>
    List<Offer>.from(json.decode(str).map((x) => Offer.fromJson(x)));

String offerToJson(List<Offer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offer {
  Offer(
      {this.id,
      this.user,
      this.userImage,
      this.offerStore,
      this.offerCredit,
      this.askingStore,
      this.askingCredit,
      this.createdAt,
      this.expiryAt,
      this.status});

  int? id;
  String? user;
  String? userImage;
  String? offerStore;
  int? offerCredit;
  String? askingStore;
  int? askingCredit;
  int? createdAt;
  int? expiryAt;
  String? status;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        user: json["user"],
        userImage: json["userImage"],
        offerStore: json["offerStore"],
        offerCredit: json["offerCredit"],
        askingStore: json["askingStore"],
        askingCredit: json["askingCredit"],
        createdAt: json["createdAt"],
        expiryAt: json["expiryAt"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "userImage": userImage,
        "offerStore": offerStore,
        "offerCredit": offerCredit,
        "askingStore": askingStore,
        "askingCredit": askingCredit,
        "createdAt": createdAt,
        "expiryAt": expiryAt,
        "status": status
      };
}
