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
import 'package:justap/models/history.dart';
import 'package:http_parser/http_parser.dart';
import 'package:universal_html/html.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';

class RemoteServices {
  static const justapAPI = "https://api.justap.us/v1";
  static var client = http.Client();

  static Future<SiteUser> fetchUser() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final response =
          await client.get(Uri.parse('$justapAPI/user?firebaseUid=$uid'),
              headers: (globals.userToken != null)
                  ? {
                      'Authorization': 'Bearer ${globals.userToken}',
                      'Accept': 'application/json; charset=UTF-8'
                    }
                  : {'Accept': 'application/json; charset=UTF-8'});
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
    String redirectURL = Uri.base.toString();
    String regexString =
        r'[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}';
    RegExp regExp = RegExp(regexString);
    RegExpMatch? match = regExp.firstMatch(redirectURL);
    String? code = match?.group(0);
    if (code != null) {
      final response = await client.get(Uri.parse('$justapAPI/user?code=$code'),
          headers: {'Accept': 'application/json; charset=UTF-8'});
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
      Uri.parse('$justapAPI/user/register'),
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
      Uri.parse('$justapAPI/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
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
      Uri.parse('$justapAPI/user/reset/code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
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
    var _request =
        http.MultipartRequest('POST', Uri.parse('$justapAPI/user/profile'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
    });

    final mimeTypeData =
        lookupMimeType(imageData.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final contentType = MediaType(mimeTypeData![0], mimeTypeData[1]);

    _request.files.add(http.MultipartFile.fromBytes(
        'profile',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString() + imageData.name,
        contentType: contentType));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update profile image');
      }
    });
  }

  static updateCroppedProfileImage(CroppedFile imageData) async {
    var _request =
        http.MultipartRequest('POST', Uri.parse('$justapAPI/user/profile'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
    });

    final mimeTypeData =
        lookupMimeType(imageData.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final contentType = MediaType(mimeTypeData![0], mimeTypeData[1]);

    _request.files.add(http.MultipartFile.fromBytes(
        'profile',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString(),
        contentType: contentType));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update profile image');
      }
    });
  }

  static updateOriginalBackgroundImage(XFile imageData) async {
    var _request =
        http.MultipartRequest('POST', Uri.parse('$justapAPI/user/background'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
    });

    final mimeTypeData =
        lookupMimeType(imageData.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final contentType = MediaType(mimeTypeData![0], mimeTypeData[1]);

    _request.files.add(http.MultipartFile.fromBytes(
      'background',
      await imageData.readAsBytes().then((value) {
        return value.cast();
      }),
      filename: imageData.path.toString() + imageData.name,
      contentType: contentType,
    ));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update background image');
      }
    });
  }

  static updateCroppedBackgroundImage(CroppedFile imageData) async {
    var _request =
        http.MultipartRequest('POST', Uri.parse('$justapAPI/user/background'));
    _request.headers.addAll({
      'authorization': 'Bearer ${globals.userToken}',
      'Content-Type': 'multipart/form-data'
    });

    final mimeTypeData =
        lookupMimeType(imageData.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final contentType = MediaType(mimeTypeData![0], mimeTypeData[1]);
    _request.files.add(http.MultipartFile.fromBytes(
        'background',
        await imageData.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: imageData.path.toString(),
        contentType: contentType));
    return await _request.send().then((value) {
      if (value.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update background image');
      }
    });
  }

  static Future<List<Media?>> fetchMedias(uid, active) async {
    if (uid != null) {
      String url = "$justapAPI/social?firebaseUid=$uid";
      if (active) {
        url += "&active=$active";
      }
      var response = await client.get(Uri.parse(url),
          headers: (globals.userToken != null)
              ? {
                  'Authorization': 'Bearer ${globals.userToken}',
                  'Accept': 'application/json; charset=UTF-8'
                }
              : {'Accept': 'application/json; charset=UTF-8'});
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
    String url = "$justapAPI/social?code=$code&active=true";
    var response = await client.get(Uri.parse(url),
        headers: {'Accept': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return mediaFromJson(jsonString);
    } else {
      return [];
    }
  }

  static Future<Media?> createMedia(socialMedia, websiteLink) async {
    final response = await http.post(
      Uri.parse('$justapAPI/social'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
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
      Uri.parse('$justapAPI/social/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
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
      Uri.parse('$justapAPI/social/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
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

  static logProfileVisit(code) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var viewerId = window.localStorage['viewerId'];
    if (viewerId == null) {
      viewerId = const Uuid().v4();
      window.localStorage['viewerId'] = viewerId;
    }
    if (uid == null) {
      await http.post(Uri.parse('$justapAPI/social/history/user/$code'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: viewerId);
    } else {
      FirebaseAuth.instance.currentUser?.getIdToken().then((value) {
        globals.userToken = value;
        http.post(Uri.parse('$justapAPI/social/history/user/$code'),
            headers: <String, String>{
              'Authorization': 'Bearer $value',
            },
            body: viewerId);
      });
    }
  }

  static logSocialVisit(code, media) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var viewerId = window.localStorage['viewerId'];
    if (viewerId == null) {
      viewerId = const Uuid().v4();
      window.localStorage['viewerId'] = viewerId;
    }
    if (uid == null) {
      await http.post(
          Uri.parse('$justapAPI/social/history/user/$code/socialMedia/$media'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: viewerId);
    } else {
      FirebaseAuth.instance.currentUser?.getIdToken().then((value) {
        globals.userToken = value;
        http.post(
            Uri.parse(
                '$justapAPI/social/history/user/$code/socialMedia/$media'),
            headers: <String, String>{
              'Authorization': 'Bearer $value',
            },
            body: viewerId);
      });
    }
  }

  static Future<List<TabHistory?>> fetchTabHistory() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken();
    String url = "$justapAPI/social/history";
    if (token != null) {
      var response = await client.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${token}',
        'Accept': 'application/json; charset=UTF-8'
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return historyFromJson(jsonString);
      } else {
        return [];
        //throw Exception('Failed to fetch history.');
      }
    } else {
      return [];
    }
  }

  static Future<TabHistory?> updateTabHistoryNotes(id, notes) async {
    final response = await http.put(
      Uri.parse('$justapAPI/social/history/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${globals.userToken}',
      },
      body: jsonEncode(<String, dynamic>{
        "notes": notes,
      }),
    );
    if (response.statusCode == 200) {
      return TabHistory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update history notes.');
    }
  }
}
