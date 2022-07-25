import 'dart:convert';

List<Media> mediaFromJson(String str) =>
    List<Media>.from(json.decode(str).map((x) => Media.fromJson(x)));

String mediaToJson(List<Media> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Media {
  Media({
    this.id,
    this.socialMedia,
    this.imageLink,
    this.websiteLink,
    this.createdAt,
    this.modifiedAt,
    this.active,
    this.owner,
    this.sequence,
  });

  int? id;
  String? socialMedia;
  String? imageLink;
  String? websiteLink;
  int? createdAt;
  int? modifiedAt;
  bool? active;
  bool? owner;
  int? sequence;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        socialMedia: json["socialMedia"],
        imageLink: json["imageLink"],
        websiteLink: json["websiteLink"],
        createdAt: json["createdAt"],
        modifiedAt: json["modifiedAt"],
        active: json["active"],
        owner: json["owner"],
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "socialMedia": socialMedia,
        "imageLink": imageLink,
        "websiteLink": websiteLink,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "active": active,
        "owner": owner,
        "sequence": sequence
      };
}
