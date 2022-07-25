import 'package:flutter/material.dart';

Widget DefaultProfileImage() => Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 42.0,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade800,
              backgroundImage:
                  AssetImage("assets/images/avatar_placeholder.png"),
            ),
          ),
          buildEditIcon(),
        ],
      ),
    );

Widget ProfileImage(image) => Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 42.0,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: NetworkImage(image),
            ),
          ),
          buildEditIcon(),
        ],
      ),
    );

Widget buildEditIcon() => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: Colors.black,
        all: 2,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 12,
        ),
      ),
    );

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
