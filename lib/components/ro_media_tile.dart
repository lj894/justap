import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/models/media.dart';
import 'package:url_launcher/url_launcher.dart';

class ROMediaTile extends StatelessWidget {
  final Media ro_media;
  const ROMediaTile(this.ro_media);

  getMediaImage(media) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(media.websiteLink))) {
          await launchUrl(Uri.parse(media.websiteLink));
        }
      }, // Image tapped
      child: Image(
        image: AssetImage("assets/images/${media.socialMedia}.png"),
        height: 100.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: getMediaImage(ro_media),
                ),
              ],
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                ro_media.socialMedia!,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
