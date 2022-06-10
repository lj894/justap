import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'dart:convert';
import 'package:justap/widgets/alert_dialog.dart';

class CreateMediaDialog extends StatefulWidget {
  @override
  _CreateMediaDialog createState() => _CreateMediaDialog();
}

class _CreateMediaDialog extends State<CreateMediaDialog> {
  String mediaType = "";
  String websiteLink = "";

  List<Map> mediaJson = [
    {'value': '', 'label': 'Select A Media'},
    {'value': 'INSTAGRAM', 'label': 'Instagram'},
    {'value': 'TWITTER', 'label': 'Twitter'},
    {'value': 'FACEBOOK', 'label': 'Facebook'},
    {'value': 'TIKTOK', 'label': 'TikTok'},
    {'value': 'BEHANCE', 'label': 'Behance'},
    {'value': 'LINKEDIN', 'label': 'LinkedIn'},
    {'value': 'YOUTUBE', 'label': 'YouTube'},
    {'value': 'SPOTIFY', 'label': 'Spotify'},
    {'value': 'VENMO', 'label': 'Venmo'},
    {'value': 'ZELLE', 'label': 'Zelle'},
    {'value': 'WECHAT', 'label': 'WeChat'},
    {'value': 'WHATSAPP', 'label': 'WhatsApp'},
    {'value': 'LINE', 'label': 'Line'},
    {'value': 'TELEGRAM', 'label': 'Telegram'},
    {'value': 'GITHUB', 'label': 'GitHub'},
  ];

  showMediaInput(context, mediaType) {
    List<String> supportedList = [
      "INSTAGRAM",
      "FACEBOOK",
      "LINKEDIN",
      "GITHUB"
    ];
    if (supportedList.contains(mediaType)) {
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
          decoration: const InputDecoration(
            labelText: 'User Name',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),
            helperText: 'Enter your user name of the site',
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
          decoration: const InputDecoration(
            labelText: 'URL',
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

  showMediaRadios() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Instagram',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "INSTAGRAM",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Twitter',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "TWITTER",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Facebook',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "FACEBOOK",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'LinkedIn',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "LINKEDIN",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'YouTube',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "YOUTUBE",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Spotify',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "SPOTIFY",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'venmo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "VENMO",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Zelle',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "ZELLE",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'WeChat',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "WECHAT",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'WhatsApp',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "WHATSAPP",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Line',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "LINE",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'TikTok',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "TIKTOK",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'Telegram',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "TELEGRAM",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Text(
                  'GitHub',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                leading: Radio(
                  value: "GITHUB",
                  groupValue: mediaType,
                  activeColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      mediaType = value.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
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
                                primary: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text("Save"),
                            onPressed: () async {
                              if (mediaType != '') {
                                String link = websiteLink;
                                if (mediaType == 'INSTAGRAM') {
                                  link = "https://instagram.com/${websiteLink}";
                                } else if (mediaType == 'FACEBOOK') {
                                  link = "https://m.facebook/${websiteLink}";
                                } else if (mediaType == 'LINKEDIN') {
                                  link =
                                      "https://www.linkedin.com/in/${websiteLink}";
                                } else if (mediaType == 'GITHUB') {
                                  link = "https://github.com/${websiteLink}";
                                }
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
                          )
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
