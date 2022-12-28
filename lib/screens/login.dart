import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:justap/screens/reset_password.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:justap/widgets/core_widgets.dart';
import 'package:justap/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:justap/widgets/google_signin.dart';
import 'package:justap/widgets/apple_signin.dart';
import 'package:provider/provider.dart';
import 'package:justap/services/authentications.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'JusTap',
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(225, 0, 0, 0)),
              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width > 700
                            ? MediaQuery.of(context).size.width * 0.35
                            : 20,
                        20,
                        MediaQuery.of(context).size.width > 700
                            ? MediaQuery.of(context).size.width * 0.35
                            : 20,
                        0),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: const Image(
                            image: AssetImage("assets/images/JUSTAP.png"),
                            width: 200.0,
                          )),
                          reusableTextField("Enter Email", Icons.person_outline,
                              false, _emailTextController, validateEmail),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: _passwordTextController,
                              validator: validatePassword,
                              obscureText: !_passwordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  color: Colors.white70,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    !_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Colors.white.withOpacity(0.3),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                              keyboardType: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 5,
                          ),
                          firebaseUIButton(context, "Sign In", () {
                            if (_key.currentState!.validate()) {
                              Future<String?> result = context
                                  .read<AuthenticationService>()
                                  .signIn(
                                      email: _emailTextController.text.trim(),
                                      password:
                                          _passwordTextController.text.trim())
                                  .then((result) {
                                if (result == 'DONE') {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (Route<dynamic> route) => false);
                                } else {
                                  showAlertDialog(context, "Error", result);
                                }
                              });
                            }
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have account?",
                                  style: TextStyle(color: Colors.white70)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: const Text(
                                  " Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPasswordScreen()));
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                              height: 50, thickness: 2, color: Colors.white),
                          const Text("Other Sign In Options",
                              style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                future:
                                    AuthenticationService.initializeFirebase(
                                        context: context),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text(
                                        'Error initializing Firebase');
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return GoogleSignInButton();
                                  }
                                  return const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFF57C00),
                                    ),
                                  );
                                },
                              ),
                              kIsWeb
                                  ? Container()
                                  : (Platform.isIOS)
                                      ? SizedBox(width: 20)
                                      : Container(),
                              kIsWeb
                                  ? Container()
                                  : (Platform.isIOS)
                                      ? FutureBuilder(
                                          future: AuthenticationService
                                              .initializeFirebase(
                                                  context: context),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return const Text('');
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.done) {
                                              return AppleSignInButton();
                                            }
                                            return const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Color(0xFFF57C00),
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          );
        }));
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  return null;
}
