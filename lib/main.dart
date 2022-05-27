import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:justap/screens/login.dart';
import 'package:justap/navigation/routes.dart';
import 'package:justap/utils/constants.dart';
import 'package:justap/screens/info.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String redirectURL = Uri.base.toString();
  String? uid = Uri.base.queryParameters["uid"];

  runApp(MyApp(redirectURL: redirectURL, uid: uid));
}

class MyApp extends StatefulWidget {
  String? redirectURL;
  String? uid;

  MyApp({this.redirectURL, this.uid});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print(widget.redirectURL);
    print(widget.uid);
    if (widget.uid != null) {
      return InfoScreen(redirectURL: widget.redirectURL, uid: widget.uid);
    } else {
      return MultiProvider(
          providers: [
            Provider<AuthenticationService>(
                create: (_) => AuthenticationService(FirebaseAuth.instance)),
            StreamProvider(
                create: (context) =>
                    context.read<AuthenticationService>().authStateChanges,
                initialData: null)
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.title,
            home: AuthenticationWrapper(),
            //initialRoute: '/',
            //onGenerateRoute: RouteGenerator.generateRoute,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          ));
    }
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    //print(user);

    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser
          ?.getIdToken()
          .then((value) => globals.userToken = value);
    }

    if (user != null) {
      return HomeScreen();
    } else if (user != null) {
      return HomeScreen();
    }
    return LoginScreen();
  }
}
