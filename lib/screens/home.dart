import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'package:justap/utils/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  var token;
  @override
  void initState() {
    super.initState();

    getToken();
  }

  getToken() async {
    token = await user?.getIdToken();
    setState(() {
      token = token;
    });
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Home Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 163, 162, 156)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  //color: Colors.amber[600],
                  child: Text('Hi! ${user?.email}'),
                ),
                Container(
                  height: 50,
                  //color: Colors.amber[500],
                  child: Text('Your token: ${token}'),
                ),
                Container(
                  height: 50,
                  //color: Colors.amber[500],
                  child: Text('Your uid: ${user?.uid}'),
                ),
                Container(
                  height: 50,
                  //color: Colors.amber[100],
                  child: Center(
                      child: ElevatedButton(
                    child: Text("Logout"),
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                      setState(() {});
                    },
                  )),
                ),
              ],
            ),
          ))),
    );
  }
}
