import 'package:flutter/material.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: TextButton(
        onPressed: () {
          setState(() {
            _isSigningIn = true;
          });
          context
              .read<AuthenticationService>()
              .signInWithGoogle(context: context);
          setState(() {
            _isSigningIn = false;
          });
        },
        child: Image(
          image: AssetImage("assets/images/google_logo.png"),
          height: 30.0,
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: Size.zero,
          padding: EdgeInsets.all(10),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
