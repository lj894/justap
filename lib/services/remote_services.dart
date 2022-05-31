import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:justap/models/media.dart';
import 'package:justap/models/user.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<SiteUser> fetchUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final response = await client.get(
        Uri.parse('https://api.justap.us/v1/user?firebaseUid=${uid}'),
        headers: {
          //'Accept': 'application/json',
          'Authorization': 'Bearer ${globals.userToken}',
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SiteUser.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  static Future<List<Media?>> fetchMedias() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      //var shorterJS = jsonString.sublist(5, 10);

      jsonString =
          '[{"id":496,"brand":"Facebook","name":"Facebook","price":"14.99","price_sign":null,"currency":null,"image_link":"https://1000logos.net/wp-content/uploads/2021/04/Facebook-logo.png","product_link":"","website_link":"","description":"Twitter","rating":5.0,"category":null,"product_type":"Social Media","tag_list":[],"product_api_url":"","api_featured_image":"","product_colors":[]}, {"id":497,"brand":"Instgram","name":"Instgram","price":"14.99","price_sign":null,"currency":null,"image_link":"https://image.similarpng.com/very-thumbnail/2020/06/Instagram-logo-transparent-PNG.png","product_link":"","website_link":"","description":"Twitter","rating":5.0,"category":null,"product_type":"Social Media","tag_list":[],"product_api_url":"","api_featured_image":"","product_colors":[]}, {"id":495,"brand":"Twitter","name":"Twitter","price":"14.99","price_sign":null,"currency":null,"image_link":"https://www.clipartmax.com/png/full/135-1352882_png-format-twitter-logo-transparent.png","product_link":"","website_link":"","description":"Twitter","rating":5.0,"category":null,"product_type":"Social Media","tag_list":[],"product_api_url":"","api_featured_image":"","product_colors":[]}]';

      //var jsonString = [{"appName": "Google", "url": "www.google.com", "logoFile": "google_logo"}];
      print(jsonString);
      return mediaFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }
}
