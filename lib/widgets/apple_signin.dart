import 'package:flutter/material.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AppleSignInButton extends StatefulWidget {
  @override
  _AppleSignInButtonState createState() => _AppleSignInButtonState();
}

class _AppleSignInButtonState extends State<AppleSignInButton> {
  bool _isSigningIn = false;

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final user =
          await context.read<AuthenticationService>().signInWithApple();
      _isSigningIn = true;
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Apple,
      mini: true,
      onPressed: () {
        _signInWithApple(context);
      },
    );
  }
}
