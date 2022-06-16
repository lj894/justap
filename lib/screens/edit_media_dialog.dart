import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'dart:convert';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:justap/utils/media_list.dart';

class EditMediaDialog extends StatefulWidget {
  Media? media;

  EditMediaDialog({this.media});

  @override
  _EditMediaDialog createState() => _EditMediaDialog();
}

class _EditMediaDialog extends State<EditMediaDialog> {
  void initState() {
    super.initState();
  }

  String? mediaType;
  String? websiteLink = "";

  showMediaInput(context, mediaType, link) {
    List<Map> targetMedia =
        mediaJson.where((m) => m['value'] == mediaType).toList();

    String prefix = targetMedia[0]['prefix'];

    if (prefix != '') {
      return Flexible(
        flex: 1,
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          initialValue: link.replaceAll(prefix, ''),
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
            helperText: 'Enter your personal link to the site',
            border: OutlineInputBorder(),
          ),
        ),
      );
    } else {
      return Flexible(
        flex: 1,
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          initialValue: link,
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
    return Column(children: [
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
    ]);
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
                hint: Text('Select Media'),
                value: mediaType,
                onChanged: null,
                // onChanged: (value) {
                //   setState(() {
                //     if (value != '') {
                //       mediaType = value.toString();
                //     }
                //   });
                // },
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
              child: Column(
                children: [
                  showMediaDropDown(),
                  //showMediaRadios(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      showMediaInput(
                          context, mediaType, widget.media?.websiteLink),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
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
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              child: const Text("Save"),
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
                                        settings:
                                            const RouteSettings(name: '/')),
                                  );
                                } catch (e) {
                                  showAlertDialog(context, "Error", "$e");
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              child: const Text("Delete"),
                              onPressed: () async {
                                await RemoteServices.deleteMedia(
                                    widget.media?.id);
                                //setState(() {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                      settings: const RouteSettings(name: '/')),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
