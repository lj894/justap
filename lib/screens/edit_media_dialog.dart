import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'dart:convert';

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

  String mediaType = "Instagram";
  String websiteLink = "";

  @override
  Widget build(BuildContext context) {
    print(widget.media?.socialMedia);
    if (widget.media?.socialMedia != null) {
      mediaType = widget.media!.socialMedia!;
    }
    if (widget.media?.websiteLink != null) {
      websiteLink = widget.media!.websiteLink!;
    }
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          title: Text('Edit Link'),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Instagram',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black),
                  ),
                  leading: Radio(
                    value: "INSTAGRAM",
                    groupValue: mediaType,
                    activeColor: Color(0xFF6200EE),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        mediaType = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Facebook',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black38),
                  ),
                  leading: Radio(
                    value: "FACEBOOK",
                    groupValue: mediaType,
                    activeColor: Color(0xFF6200EE),
                    onChanged: null,
                    // onChanged: (value) {
                    //   print(value);
                    //   setState(() {
                    //     mediaType = value.toString();
                    //   });
                    // },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Twitter',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black38),
                  ),
                  leading: Radio(
                    value: "TWITTER",
                    groupValue: mediaType,
                    activeColor: Color(0xFF6200EE),
                    onChanged: null,
                    // onChanged: (value) {
                    //   print(value);
                    //   setState(() {
                    //     mediaType = value.toString();
                    //   });
                    // },
                  ),
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: websiteLink,
                  //maxLength: 50,
                  onChanged: (value) {
                    setState(() {
                      websiteLink = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'URL',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: 'Your personal link',
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      //color: Colors.amber[100],
                      child: Center(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //primary: Colors.redAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 56, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        child: const Text("Save"),
                        onPressed: () async {
                          await RemoteServices.createMedias(
                              mediaType.toUpperCase(), websiteLink);
                          //setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                                settings: const RouteSettings(name: '/')),
                          );
                        },
                      )),
                    ),
                    Container(
                      height: 50,
                      //color: Colors.amber[100],
                      child: Center(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        child: const Text("Delete"),
                        onPressed: () async {
                          await RemoteServices.createMedias(
                              mediaType.toUpperCase(), websiteLink);
                          //setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                                settings: const RouteSettings(name: '/')),
                          );
                        },
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
