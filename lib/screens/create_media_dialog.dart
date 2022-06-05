import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/models/media.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'dart:convert';

class CreateMediaDialog extends StatefulWidget {
  @override
  _CreateMediaDialog createState() => _CreateMediaDialog();
}

class _CreateMediaDialog extends State<CreateMediaDialog> {
  String mediaType = "INSTAGRAM";
  String websiteLink = "https://";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          title: Text('Create Link'),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
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
                          activeColor: const Color(0xFF6200EE),
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
                          'Facebook',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        leading: Radio(
                          value: "FACEBOOK",
                          groupValue: mediaType,
                          activeColor: const Color(0xFF6200EE),
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
                          'LinkedIn',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        leading: Radio(
                          value: "LINKEDIN",
                          groupValue: mediaType,
                          activeColor: const Color(0xFF6200EE),
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
                          'WeChat',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        leading: Radio(
                          value: "WECHAT",
                          groupValue: mediaType,
                          activeColor: const Color(0xFF6200EE),
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
                          'Trello',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        leading: Radio(
                          value: "TRELLO",
                          groupValue: mediaType,
                          activeColor: const Color(0xFF6200EE),
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
                          activeColor: const Color(0xFF6200EE),
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
                          activeColor: const Color(0xFF6200EE),
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
                          activeColor: const Color(0xFF6200EE),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
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
                            color: Color(0xFF6200EE),
                          ),
                          helperText: 'Enter your personal link to the site',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
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
                                //primary: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 56, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text("Save"),
                            onPressed: () async {
                              await RemoteServices.createMedia(
                                  mediaType, websiteLink);
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
          ),
        ));
  }
}
