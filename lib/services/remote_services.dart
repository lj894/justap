import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:justap/models/media.dart';
import 'package:justap/models/user.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<SiteUser> fetchUser() async {
    String? uid = Uri.base.queryParameters["uid"];
    uid ??= FirebaseAuth.instance.currentUser?.uid;

    final response = await client.get(
        Uri.parse('https://api.justap.us/v1/user?firebaseUid=${uid}'),
        headers: (globals.userToken != null)
            ? {'Authorization': 'Bearer ${globals.userToken}'}
            : null);

    if (response.statusCode == 200) {
      return SiteUser.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 204) {
      return createUser();
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<SiteUser> createUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final response = await http.post(
      Uri.parse('https://api.justap.us/v1/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, String>{
        //"nickName": "string",
        //"introduction": "string"
      }),
    );

    if (response.statusCode == 200) {
      return SiteUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  static Future<List<Media?>> fetchMedias(uid) async {
    var response = await client.get(
        Uri.parse("https://api.justap.us/v1/social?firebaseUid=${uid}"),
        headers: (globals.userToken != null)
            ? {'Authorization': 'Bearer ${globals.userToken}'}
            : null);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return mediaFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Media?> createMedia(socialMedia, websiteLink) async {
    final response = await http.post(
      Uri.parse('https://api.justap.us/v1/social'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{
        "socialMedia": socialMedia,
        "websiteLink": websiteLink,
        "imageLink": null,
        "enable": true
      }),
    );

    if (response.statusCode == 200) {
      return Media.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create social media.');
    }
  }

  static Future<Media?> updateMedia(id, socialMedia, websiteLink) async {
    print(socialMedia);
    print(websiteLink);

    final response = await http.put(
      Uri.parse('https://api.justap.us/v1/social/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{
        "socialMedia": socialMedia,
        "websiteLink": websiteLink,
        "enable": true
      }),
    );
    if (response.statusCode == 200) {
      return Media.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update social media.');
    }
  }

  static Future<void> deleteMedia(id) async {
    final response = await http.delete(
      Uri.parse('https://api.justap.us/v1/social/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    if (response.statusCode == 204) {
      return null;
    } else {
      throw Exception('Failed to delete social media.');
    }
  }
}
