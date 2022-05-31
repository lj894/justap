import 'dart:convert';

class SiteUser {
  final String nickName;
  final String? introduction;
  final String email;
  final String? profileUrl;
  final bool owner;

  const SiteUser({
    required this.nickName,
    this.introduction,
    required this.email,
    this.profileUrl,
    required this.owner,
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
