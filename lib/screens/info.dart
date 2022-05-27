import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'package:justap/utils/globals.dart' as globals;

class InfoScreen extends StatefulWidget {
  String? redirectURL;
  String? uid;

  InfoScreen({this.redirectURL, this.uid});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
  }
  // var token;
  // @override
  // void initState() {
  //   super.initState();

  //   getToken();
  // }

  // getToken() async {
  //   token = await user?.getIdToken();
  //   setState(() {
  //     token = token;
  //   });
  //   print(token);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Info Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 163, 162, 156)),
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      //color: Colors.amber[600],
                      child: Text('Hi! ${widget.uid}'),
                    ),
                  ],
                ),
              ))),
        );
      }),
    );
  }
}
