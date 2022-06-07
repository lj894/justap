import 'package:flutter/material.dart';

Widget CoverImage() => Container(
    margin: const EdgeInsets.only(bottom: 5),
    color: Colors.grey,
    child: Image.asset(
      "assets/images/profile_background.png",
      width: double.infinity,
      height: 120,
      fit: BoxFit.cover,
    ));
