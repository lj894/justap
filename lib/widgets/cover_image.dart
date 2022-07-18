import 'package:flutter/material.dart';
import 'package:justap/screens/Image_upload.dart';

Widget CoverImage(url, context) =>
    Stack(alignment: Alignment.bottomRight, children: <Widget>[
      url != null
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
            ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ImageUpload(
                      title: "Upload Background Image", type: "BACKGROUND"),
                  fullscreenDialog: true,
                ),
              );
            },
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(3),
                color: Colors.black,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            )),
      ),
    ]);
