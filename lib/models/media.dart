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
    this.enable,
    this.owner,
  });

  int? id;
  String? socialMedia;
  String? imageLink;
  String? websiteLink;
  int? createdAt;
  int? modifiedAt;
  bool? enable;
  bool? owner;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        socialMedia: json["socialMedia"] == null ? null : json["socialMedia"],
        imageLink: json["imageLink"] == null ? null : json["imageLink"],
        websiteLink: json["websiteLink"] == null ? null : json["websiteLink"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        modifiedAt: json["modifiedAt"] == null ? null : json["modifiedAt"],
        enable: json["enable"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "socialMedia": socialMedia == null ? null : socialMedia,
        "imageLink": imageLink == null ? null : imageLink,
        "websiteLink": websiteLink == null ? null : websiteLink,
        "createdAt": createdAt == null ? null : createdAt,
        "modifiedAt": modifiedAt == null ? null : modifiedAt,
        "enable": enable,
        "owner": owner,
      };
}
