import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:justap/utils/media_list.dart';
import 'package:scan/scan.dart';

class EditMediaDialog extends StatefulWidget {
  Media? media;

  EditMediaDialog({this.media});

  @override
  _EditMediaDialog createState() => _EditMediaDialog();
}

class _EditMediaDialog extends State<EditMediaDialog> {
  void initState() {
    super.initState();
    if (!kIsWeb) {
      initPlatformState();
    }
  }

  String? mediaType;
  String? websiteLink = "";
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';

  TextEditingController txt = TextEditingController();

  showMediaInput(context, mediaType, link) {
    List<Map> targetMedia =
        mediaJson.where((m) => m['value'] == mediaType).toList();
    String prefix = targetMedia[0]['prefix'];
    String? inputLabel = targetMedia[0]['input_label'];

    if (mediaType == 'ZELLE') {
      if (link == "") {
        return Container();
      } else {
        return Flexible(
          flex: 1,
          child: TextFormField(
            //cursorColor: Theme.of(context).cursorColor,
            initialValue: qrcode != 'Unknown' ? qrcode : link,
            //maxLength: 50,
            onChanged: (value) {
              setState(() {
                websiteLink = value.toString();
              });
            },
            decoration: const InputDecoration(
              labelText: "Link",
              labelStyle: TextStyle(
                color: Colors.black87,
              ),
              //helperText: 'Enter your user name of the site',
              border: OutlineInputBorder(),
            ),
          ),
        );
      }
    } else if (prefix != '') {
      return Flexible(
        flex: 1,
        child: TextFormField(
          //cursorColor: Theme.of(context).cursorColor,
          initialValue: link.replaceAll(prefix, ''),
          //maxLength: 50,
          onChanged: (value) {
            setState(() {
              websiteLink = value.toString();
            });
          },
          decoration: InputDecoration(
            labelText: inputLabel,
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            helperText: 'Enter your personal link to the site',
            border: OutlineInputBorder(),
          ),
        ),
      );
    } else {
      return Flexible(
        flex: 1,
        child: TextFormField(
          //cursorColor: Theme.of(context).cursorColor,
          initialValue: link,
          onChanged: (value) {
            setState(() {
              websiteLink = value.toString();
            });
          },
          decoration: InputDecoration(
            labelText: inputLabel,
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            helperText: 'Enter your personal link to the site',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }
    // true
  }

  showQRInput(context, mediaType, qrcode) {
    if (mediaType == 'ZELLE' && !kIsWeb) {
      txt.value = TextEditingValue(
          text: qrcode,
          selection:
              TextSelection.fromPosition(TextPosition(offset: qrcode.length)));
      return Flexible(
        flex: 1,
        child: TextFormField(
          //cursorColor: Theme.of(context).cursorColor,
          controller: txt,
          onChanged: (value) {
            txt.value = TextEditingValue(
                text: value,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: value.length),
                ));
            setState(() {
              websiteLink = value.toString();
            });
          },
          decoration: const InputDecoration(
            labelText: "Link",
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            border: OutlineInputBorder(),
          ),
        ),
      );
    }
  }

  showMediaDropDown() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                hint: const Text('Select Media'),
                value: mediaType,
                onChanged: null,
                items: mediaJson.map((media) {
                  return DropdownMenuItem(
                      value: media['value'].toString(),
                      child: Row(
                        children: [
                          if (media['value'] != '')
                            Image.asset("assets/images/${media['value']}.png",
                                width: 25),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(media['label']),
                          )
                        ],
                      ));
                }).toList(),
              ),
            )))
          ],
        ));
  }

  showQRProcessor(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.grey)),
              primary: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              textStyle:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          child: const Text("Upload Zelle QR Code Image"),
          onPressed: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              String? str = await Scan.parse(pickedFile.path);
              if (str != null) {
                setState(() {
                  qrcode = str;
                  websiteLink = str;
                });
              }
            }
          },
        )
      ],
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mediaType == null && widget.media?.socialMedia != null) {
      setState(() {
        mediaType = widget.media!.socialMedia!;
      });
    }
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text("Edit Media Link",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(children: [
                showMediaDropDown(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                if (mediaType == 'ZELLE' && !kIsWeb) showQRProcessor(context),
                (qrcode == 'Unknown' || kIsWeb)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          showMediaInput(
                              context, mediaType, widget.media?.websiteLink),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          showQRInput(context, mediaType, qrcode),
                        ],
                      ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.grey)),
                                primary: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text("SAVE"),
                            onPressed: () async {
                              String? link = '';
                              List<Map> targetMedia = mediaJson
                                  .where((m) => m['value'] == mediaType)
                                  .toList();
                              String prefix = targetMedia[0]['prefix'];

                              if (websiteLink != null && websiteLink != '') {
                                link = websiteLink;
                              } else {
                                link = widget.media?.websiteLink;
                                if (prefix != '') {
                                  link = link!.replaceAll(prefix, '');
                                }
                              }
                              link = prefix + link!;

                              if (mediaType == 'ZELLE' && !kIsWeb) {
                                link = websiteLink;
                              }

                              try {
                                await RemoteServices.updateMedia(
                                    widget.media?.id,
                                    mediaType,
                                    link,
                                    widget.media?.active);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                      settings: const RouteSettings(name: '/')),
                                );
                              } catch (e) {
                                showAlertDialog(context, "Error", "$e");
                              }
                            },
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.grey)),
                                primary: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text("DELETE"),
                            onPressed: () async {
                              showConfirmDialog(
                                  context,
                                  "Delete Social Media Link",
                                  "Are you sure you wish to delete ${widget.media?.socialMedia}?",
                                  () => () async {
                                        await RemoteServices.deleteMedia(
                                            widget.media?.id);
                                        //setState(() {});
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                              settings: const RouteSettings(
                                                  name: '/')),
                                        );
                                      });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ]),
            )));
  }
}
