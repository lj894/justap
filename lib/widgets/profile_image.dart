import 'dart:html';

import 'package:flutter/material.dart';

Widget DefaultProfileImage() => CircleAvatar(
      backgroundColor: Colors.white,
      radius: 42.0,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage("assets/images/avatar_placeholder.png"),
      ),
    );

Widget ProfileImage(image) => CircleAvatar(
      backgroundColor: Colors.white,
      radius: 42.0,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(image),
      ),
    );
