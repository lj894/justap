import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:justap/models/media.dart';
import 'package:justap/models/user.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<SiteUser> fetchUser() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final response = await client.get(
          Uri.parse('https://api.justap.us/v1/user?firebaseUid=${uid}'),
          headers: (globals.userToken != null)
              ? {'Authorization': 'Bearer ${globals.userToken}'}
              : null);
      if (response.statusCode == 200) {
        return SiteUser.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 204 || response.statusCode == 404) {
        return createUser();
      } else {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<SiteUser> fetchUserByCode() async {
    String? code = Uri.base.queryParameters["code"];
    if (code != null) {
      final response = await client
          .get(Uri.parse('https://api.justap.us/v1/user?code=${code}'));
      if (response.statusCode == 200) {
        return SiteUser.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    }
    throw Exception('Failed to load user');
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

  static Future<SiteUser?> updateProfile(nickName, introduction) async {
    final response = await http.put(
      Uri.parse('https://api.justap.us/v1/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{
        "nickName": nickName,
        "introduction": introduction,
      }),
    );
    if (response.statusCode == 200) {
      return SiteUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile.');
    }
  }

  static Future<SiteUser?> resetProfileCode() async {
    final response = await http.post(
      Uri.parse('https://api.justap.us/v1/user/reset/code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    if (response.statusCode == 200) {
      return SiteUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile.');
    }
  }

  static Future<SiteUser?> updateProfileImage(File imageFile) async {
    http.ByteStream stream =
        http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    int length = await imageFile.length();
    Uri uri = Uri.parse('https://api.justap.us/v1/user/profile');
    http.MultipartRequest request = http.MultipartRequest("POST", uri);
    request.headers['authorization'] = 'Bearer ${globals.userToken}';
    http.MultipartFile multipartFile = http.MultipartFile(
        'file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    //print(response.statusCode);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    final responseStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return SiteUser.fromJson(jsonDecode(responseStr));
    } else {
      throw Exception('Failed to update profile image.');
    }
  }

  static Future<SiteUser?> updateBackgroundImage() async {
    final response = await http.post(
      Uri.parse('https://api.justap.us/v1/user/background'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    if (response.statusCode == 200) {
      return SiteUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update background image.');
    }
  }

  static Future<List<Media?>> fetchMedias(uid, active) async {
    if (uid != null) {
      String url = "https://api.justap.us/v1/social?firebaseUid=${uid}";
      if (active) {
        url += "&active=${active}";
      }
      var response = await client.get(Uri.parse(url),
          headers: (globals.userToken != null)
              ? {'Authorization': 'Bearer ${globals.userToken}'}
              : null);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return mediaFromJson(jsonString);
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch medias.');
    }
  }

  static Future<List<Media?>> fetchMediasByCode(code) async {
    String url = "https://api.justap.us/v1/social?code=${code}&active=true";
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return mediaFromJson(jsonString);
    } else {
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
        "active": true
      }),
    );

    if (response.statusCode == 200) {
      return Media.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<Media?> updateMedia(
      id, socialMedia, websiteLink, status) async {
    final response = await http.put(
      Uri.parse('https://api.justap.us/v1/social/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{
        "socialMedia": socialMedia,
        "websiteLink": websiteLink,
        "active": status
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
