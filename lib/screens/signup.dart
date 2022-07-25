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
                    reusableTextField("Password", Icons.lock_outlined, true,
                        _passwordTextController, validatePassword),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Repeat Password", Icons.lock_outlined,
                        true, _repeatPasswordTextController, validatePassword),
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
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.,/]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';
  return null;
}
