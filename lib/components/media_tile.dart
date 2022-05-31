import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/models/media.dart';

class MediaTile extends StatelessWidget {
  final Media media;
  const MediaTile(this.media);

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
                  child: Image.network(
                    media.imageLink,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                media.name,
                //"Twitter",
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
