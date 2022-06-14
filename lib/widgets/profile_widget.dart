import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final color = Theme.of(context).colorScheme.primary;
    const color = Colors.black;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image;
    if (imagePath.contains("assets/images")) {
      image = ExactAssetImage(imagePath);
    } else {
      image = NetworkImage(imagePath);
    }
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 42.0,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: image,
        child: InkWell(onTap: onClicked),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
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
}
