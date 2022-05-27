import 'package:justap/screens/home.dart';
import 'package:justap/screens/login.dart';
import 'package:justap/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home':
        if (FirebaseAuth.instance.currentUser != null) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
