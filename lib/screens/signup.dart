import 'package:justap/widgets/alert_dialog.dart';
import 'package:justap/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justap/services/authentications.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _repeatPasswordTextController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _passwordVisible = false, _repeatPasswordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    _repeatPasswordVisible = false;
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _repeatPasswordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "SIGN UP",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 55, 55, 55)),
          child: Form(
              key: _key,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Email Address", Icons.person_outline,
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
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
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
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        keyboardType: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _repeatPasswordTextController,
                        validator: validatePassword,
                        obscureText: !_repeatPasswordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              !_repeatPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _repeatPasswordVisible =
                                    !_repeatPasswordVisible;
                              });
                            },
                          ),
                          labelText: "Repeat Password",
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        keyboardType: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      if (_key.currentState!.validate()) {
                        if (_passwordTextController.text ==
                            _repeatPasswordTextController.text) {
                          Future<String?> result = context
                              .read<AuthenticationService>()
                              .signUp(
                                  email: _emailTextController.text.trim(),
                                  password: _passwordTextController.text.trim())
                              .then((result) {
                            if (result == 'DONE') {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            } else {
                              showAlertDialog(context, "Error", result);
                            }
                          });
                        } else {
                          showAlertDialog(
                              context, "Error", "passward not match");
                        }
                      }
                    })
                  ],
                ),
              ))),
    );
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
  // String pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.,/]).{8,}$';
  // RegExp regex = RegExp(pattern);
  // if (!regex.hasMatch(formPassword))
  //   return '''
  //     Password must be at least 8 characters,
  //     include an uppercase letter, number and symbol.
  //     ''';
  if (formPassword.length < 8)
    return '''
        Password must be at least 8 characters.
        ''';
  return null;
}
