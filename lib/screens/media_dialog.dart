import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'dart:convert';

class MediaDialog extends StatefulWidget {
  @override
  _MediaDialog createState() => _MediaDialog();
}

class _MediaDialog extends State<MediaDialog> {
  String mediaType = "Instagram";
  String websiteLink = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          title: Text('Create Link'),
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
                    value: "Instagram",
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
                    value: "Facebook",
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
                    value: "Twitter",
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
                  initialValue: '',
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
                Container(
                  height: 50,
                  //color: Colors.amber[100],
                  child: Center(
                      child: ElevatedButton(
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
              ],
            ),
          ),
        ));
  }
}
