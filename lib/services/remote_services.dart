import 'dart:convert';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:justap/models/media.dart';
import 'package:justap/models/user.dart';
import 'package:http_parser/http_parser.dart';

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

  static updateOriginalProfileImage(XFile imageData) async {
    // final response =
    //     await http.post(Uri.parse("https://api.justap.us/v1/user/profile"),
    //         // headers: {'Content-Type': 'application/octet-stream'},
    //         headers: {
    //           'Content-Type': 'multipart/form-data',
    //           'authorization': 'Bearer ${globals.userToken}'
    //         },
    //         body: imageData);
    // if (response.statusCode == 200) {
    //   return Media.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to update social media.');
    // }
    var _request = http.MultipartRequest(
        'POST', Uri.parse('https://api.justap.us/v1/user/profile'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
      //'application/x-www-form-urlencoded'
    });
    _request.files.add(http.MultipartFile.fromBytes(
        'profile',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString() + imageData.name));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update profile image');
      }
    });
  }

  static updateCroppedProfileImage(CroppedFile imageData) async {
    // final response =
    //     await http.post(Uri.parse("https://api.justap.us/v1/user/profile"),
    //         // headers: {'Content-Type': 'application/octet-stream'},
    //         headers: {
    //           'Content-Type': 'multipart/form-data',
    //           'authorization': 'Bearer ${globals.userToken}'
    //         },
    //         body: imageData);
    // if (response.statusCode == 200) {
    //   return Media.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to update social media.');
    // }
    var _request = http.MultipartRequest(
        'POST', Uri.parse('https://api.justap.us/v1/user/profile'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
      //'application/x-www-form-urlencoded'
    });
    _request.files.add(http.MultipartFile.fromBytes(
        'profile',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString()));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update profile image');
      }
    });
  }

  static updateOriginalBackgroundImage(XFile imageData) async {
    // final response =
    //     await http.post(Uri.parse("https://api.justap.us/v1/user/profile"),
    //         // headers: {'Content-Type': 'application/octet-stream'},
    //         headers: {
    //           'Content-Type': 'multipart/form-data',
    //           'authorization': 'Bearer ${globals.userToken}'
    //         },
    //         body: imageData);
    // if (response.statusCode == 200) {
    //   return Media.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to update social media.');
    // }
    var _request = http.MultipartRequest(
        'POST', Uri.parse('https://api.justap.us/v1/user/background'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
      //'application/x-www-form-urlencoded'
    });
    _request.files.add(http.MultipartFile.fromBytes(
        'background',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString() + imageData.name));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update background image');
      }
    });
  }

  static updateCroppedBackgroundImage(CroppedFile imageData) async {
    // final response =
    //     await http.post(Uri.parse("https://api.justap.us/v1/user/profile"),
    //         // headers: {'Content-Type': 'application/octet-stream'},
    //         headers: {
    //           'Content-Type': 'multipart/form-data',
    //           'authorization': 'Bearer ${globals.userToken}'
    //         },
    //         body: imageData);
    // if (response.statusCode == 200) {
    //   return Media.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to update social media.');
    // }
    var _request = http.MultipartRequest(
        'POST', Uri.parse('https://api.justap.us/v1/user/background'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
      //'application/x-www-form-urlencoded'
    });
    _request.files.add(http.MultipartFile.fromBytes(
        'background',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString()));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update background image');
      }
    });
  }

  static updateBackgroundImage(imageData) async {
    var postUri = Uri.parse("https://api.justap.us/v1/user/background");
    var request = http.MultipartRequest("POST", postUri);
    request.headers['authorization'] = 'Bearer ${globals.userToken}';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(http.MultipartFile.fromBytes('profile', imageData,
        contentType: MediaType('image', 'jpeg')));

    request.send().then((response) {
      if (response.statusCode == 200) {
        print('done');
      } else {
        throw Exception('Failed to update profile image.');
      }
    });
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
