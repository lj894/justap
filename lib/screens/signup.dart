import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/widgets/core_widgets.dart';
import 'package:justap/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justap/services/authentications.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _repeatPasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
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
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Email Address", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Repeat Password", Icons.lock_outlined, true,
                    _repeatPasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  if (_passwordTextController.text ==
                      _repeatPasswordTextController.text) {
                    context.read<AuthenticationService>().signUp(
                        email: _emailTextController.text.trim(),
                        password: _passwordTextController.text.trim());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  }
                })
              ],
            ),
          ))),
    );
  }
}
