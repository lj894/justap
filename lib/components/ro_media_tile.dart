import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:justap/models/media.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:justap/utils/media_list.dart';

class ROMediaTile extends StatelessWidget {
  final Media ro_media;
  final String? code;
  const ROMediaTile(this.ro_media, this.code);

  getMediaImage(context, media) {
    return GestureDetector(
      onTap: () async {
        RemoteServices.logSocialVisit(code, media.socialMedia);
        if (await canLaunchUrl(Uri.parse(media.websiteLink))) {
          await launchUrl(Uri.parse(media.websiteLink));
        } else {
          if (media.socialMedia == "WECHAT") {
            List<Map> targetMedia = mediaJson
                .where((m) => m['value'] == media.socialMedia)
                .toList();

            String prefix = targetMedia[0]['prefix'];

            String userName = media.websiteLink.replaceAll(prefix, "");

            Clipboard.setData(ClipboardData(text: "${userName}"));
            showConfirmDialog(
                context,
                "User Name Copied",
                "You will be redirect to the WeChat.",
                () => () {
                      html.window.open(media.websiteLink, "Justap");
                    });
          } else {
            html.window.open(media.websiteLink, "Justap");
          }
        }
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
                  child: getMediaImage(context, ro_media),
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
