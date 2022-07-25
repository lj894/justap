import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/edit_media_dialog.dart';
import 'package:justap/services/remote_services.dart';

class MediaTile extends StatefulWidget {
  final Media? media;

  MediaTile({this.media});

  @override
  _MediaTile createState() => _MediaTile();
}

class _MediaTile extends State<MediaTile> {
  @override
  void initState() {
    super.initState();
    active = widget.media!.active!;
  }

  bool active = false;

  getMediaImage(context, media) {
    return Container(
      child: Image(
        image: AssetImage("assets/images/${media.socialMedia}.png"),
        height: 50.0,
        width: 50.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Padding(
            padding: kIsWeb
                ? EdgeInsets.fromLTRB(2.0, 2.0, 30.0, 2.0)
                : EdgeInsets.all(2.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              EditMediaDialog(media: widget.media),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: getMediaImage(context, widget.media),
                        ),
                        SizedBox(width: 15),
                        Text(
                          widget.media!.socialMedia!,
                          maxLines: 1,
                          style: const TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  EditMediaDialog(media: widget.media),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: const Icon(Icons.edit, color: Colors.black),
                      ),
                      const SizedBox(width: 5),
                      Switch(
                        value: active,
                        onChanged: (value) async {
                          await RemoteServices.updateMedia(
                              widget.media!.id,
                              widget.media!.socialMedia,
                              widget.media?.websiteLink,
                              value);
                          setState(() {
                            active = value;
                          });
                        },
                        activeTrackColor: Colors.black,
                        activeColor: Colors.white60,
                      ),
                      if (!kIsWeb) ...[
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.drag_handle,
                              color: Colors.black),
                        ),
                      ],
                    ],
                  )
                ])));
  }
}
