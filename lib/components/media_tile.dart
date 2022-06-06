import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/edit_media_dialog.dart';

class MediaTile extends StatelessWidget {
  final Media media;
  const MediaTile(this.media);

  getMediaImage(context, media) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => EditMediaDialog(media: media),
            fullscreenDialog: true,
          ),
        );
      }, // Image tapped
      child: Image(
        image: AssetImage("assets/images/${media.socialMedia}.png"),
        height: 50.0,
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
                  height: 100,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: getMediaImage(context, media),
                ),
              ],
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                media.socialMedia!,
                maxLines: 2,
                style: TextStyle(
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
