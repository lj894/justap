import 'dart:convert';

class SiteUser {
  String? nickName;
  String? introduction;
  String? email;
  String? profileUrl;
  bool? owner;

  SiteUser({
    this.nickName,
    this.introduction,
    this.email,
    this.profileUrl,
    this.owner,
  });

  factory SiteUser.fromJson(Map<String, dynamic> json) {
    return SiteUser(
      nickName: json['nickName'],
      introduction: json['introduction'],
      email: json['email'],
      profileUrl: json['profileUrl'],
      owner: json['owner'],
    );
  }
}
