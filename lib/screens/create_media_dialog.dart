import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:justap/utils/media_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';
import 'dart:async';

class CreateMediaDialog extends StatefulWidget {
  @override
  _CreateMediaDialog createState() => _CreateMediaDialog();
}

class _CreateMediaDialog extends State<CreateMediaDialog> {
  String mediaType = "";
  String websiteLink = "";

  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  showMediaInput(context, mediaType) {
    List<Map> targetMedia =
        mediaJson.where((m) => m['value'] == mediaType).toList();

    String prefix = targetMedia[0]['prefix'];
    String? inputLabel = targetMedia[0]['input_label'];

    if (mediaType == 'ZELLE' && !kIsWeb) {
      if (qrcode == "Unknown") {
        return Container();
      } else {
        return Flexible(
          flex: 1,
          child: TextFormField(
            cursorColor: Theme.of(context).cursorColor,
            initialValue: qrcode,
            //maxLength: 50,
            onChanged: (value) {
              setState(() {
                websiteLink = value.toString();
              });
            },
            decoration: InputDecoration(
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
          cursorColor: Theme.of(context).cursorColor,
          initialValue: websiteLink.split("/").last,
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
            //helperText: 'Enter your user name of the site',
            border: OutlineInputBorder(),
          ),
        ),
      );
    } else {
      return Flexible(
        flex: 1,
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          initialValue: websiteLink,
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
            //helperText: 'Enter your personal link to the site',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }
    // true
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
                menuMaxHeight: 400,
                hint: const Text('Select Media'),
                value: mediaType,
                onChanged: (value) {
                  setState(() {
                    if (value != '') {
                      mediaType = value.toString();
                    }
                  });
                },
                items: mediaJson.map((media) {
                  return DropdownMenuItem(
                      value: media['value'].toString(),
                      child: Row(
                        children: [
                          media['value'] != ''
                              ? Image.asset(
                                  "assets/images/${media['value']}.png",
                                  width: 25)
                              : Container(),
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
        //Text('Running on: $_platformVersion\n'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.grey)),
              primary: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              textStyle:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          child: const Text("Read QR Code Image"),
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
    //Text('scan result is $qrcode'),
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
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text("Create Media Link",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //showMediaRadios(),
                showMediaDropDown(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                mediaType == 'ZELLE' && !kIsWeb
                    ? showQRProcessor(context)
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mediaType != ''
                        ? showMediaInput(context, mediaType)
                        : Container(),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              if (mediaType != '') {
                                String link = websiteLink;

                                List<Map> targetMedia = mediaJson
                                    .where((m) => m['value'] == mediaType)
                                    .toList();

                                String prefix = targetMedia[0]['prefix'];

                                link = prefix + websiteLink;

                                try {
                                  await RemoteServices.createMedia(
                                      mediaType, link);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                        settings:
                                            const RouteSettings(name: '/')),
                                  );
                                } catch (e) {
                                  showAlertDialog(context, "Error", "$e");
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
