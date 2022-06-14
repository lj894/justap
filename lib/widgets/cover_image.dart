import 'package:flutter/material.dart';

Widget CoverImage(url) => Container(
    color: Colors.grey,
    child: url != null
        ? Image.network(
            url,
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          )
        : Image.asset(
            "assets/images/profile_background.png",
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          ));
