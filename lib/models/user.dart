import 'dart:convert';

class SiteUser {
  String? nickName;
  String? introduction;
  String? email;
  String? profileUrl;
  String? backgroundUrl;
  String? code;
  bool? owner;

  SiteUser({
    this.nickName,
    this.introduction,
    this.email,
    this.profileUrl,
    this.backgroundUrl,
    this.code,
    this.owner,
  });

  factory SiteUser.fromJson(Map<String, dynamic> json) {
    return SiteUser(
      nickName: json['nickName'],
      introduction: json['introduction'],
      email: json['email'],
      profileUrl: json['profileUrl'],
      backgroundUrl: json['backgroundUrl'],
      code: json['code'],
      owner: json['owner'],
    );
  }
}
