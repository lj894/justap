import 'package:justap/screens/home.dart';
import 'package:justap/screens/login.dart';
import 'package:justap/screens/signup.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const LoginScreen(),
    '/sign-up': (context) => const SignUpScreen(),
    '/home': (context) => const HomeScreen()
  };
}
