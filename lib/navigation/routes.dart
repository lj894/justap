import 'package:justap/screens/home.dart';
import 'package:justap/screens/login.dart';
import 'package:justap/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Routes {
  User? user = FirebaseAuth.instance.currentUser;

  // if (user != null) {
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => HomeScreen(
  //         user: user,
  //       ),
  //     ),
  //   );
  // }

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const LoginScreen(),
    '/sign-up': (context) => const SignUpScreen(),
    //'/home': (context) => HomeScreen(user: user ? )
  };
}
