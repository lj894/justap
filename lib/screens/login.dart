import 'package:justap/widgets/core_widgets.dart';
import 'package:justap/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:justap/widgets/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:justap/services/authentications.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Justap',
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 99, 203, 255)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const Center(
                          child: Text("JusTap",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 30,
                      ),
                      reusableTextField("Enter UserName", Icons.person_outline,
                          false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      //forgetPassword(context),
                      firebaseUIButton(context, "Sign In", () {
                        context.read<AuthenticationService>().signIn(
                            email: _emailTextController.text.trim(),
                            password: _passwordTextController.text.trim());
                        //setState(() {});
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
                                      builder: (context) => SignUpScreen()));
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
                      const Divider(
                          height: 50, thickness: 2, color: Colors.white),
                      FutureBuilder(
                        future: AuthenticationService.initializeFirebase(
                            context: context),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error initializing Firebase');
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
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
