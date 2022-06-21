import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:justap/screens/all.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controllers/navigation.dart';
import 'package:justap/utils/globals.dart' as globals;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String redirectURL = Uri.base.toString();

  String regexString =
      r'[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}';
  RegExp regExp = RegExp(regexString);
  RegExpMatch? match = regExp.firstMatch(redirectURL);
  String? code = match?.group(0);
  //String? code = Uri.base.queryParameters["code"];
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseAuth.instance.currentUser
        ?.getIdToken()
        .then((value) => globals.userToken = value);
  }
  runApp(MyApp(redirectURL: redirectURL, code: code));
}

class MyApp extends StatefulWidget {
  String? redirectURL;
  String? code;

  MyApp({this.redirectURL, this.code});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    if (widget.code != null) {
      return MultiProvider(
          providers: [
            Provider<AuthenticationService>(
                create: (_) => AuthenticationService(FirebaseAuth.instance)),
            StreamProvider(
                create: (context) =>
                    context.read<AuthenticationService>().authStateChanges,
                initialData: null),
            ListenableProvider<NavigationController>(
              create: (_) => NavigationController(),
            )
          ],
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return MaterialApp(
                      title: 'JusTap',
                      initialRoute: "/${widget.code}",
                      routes: <String, WidgetBuilder>{
                        "/${widget.code}": (context) => InfoScreen(
                            redirectURL: widget.redirectURL, code: widget.code),
                        "/?code=${widget.code}": (context) => InfoScreen(
                            redirectURL: widget.redirectURL, code: widget.code),
                      },
                      home: InfoScreen(
                          redirectURL: widget.redirectURL, code: widget.code));
                }
              }));
    } else {
      return MultiProvider(
          providers: [
            Provider<AuthenticationService>(
                create: (_) => AuthenticationService(FirebaseAuth.instance)),
            StreamProvider(
                create: (context) =>
                    context.read<AuthenticationService>().authStateChanges,
                initialData: null),
            ListenableProvider<NavigationController>(
              create: (_) => NavigationController(),
            )
          ],
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data != null) {
                  return const AuthenticationWrapper();
                }
                return LoginScreen();
              }));
    }
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context);

    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser
          ?.getIdToken()
          .then((value) => globals.userToken = value);
    }
    return MaterialApp(
      title: 'JusTap',
      initialRoute: "/",
      home: Navigator(
        pages: [
          MaterialPage(child: HomeScreen()),
          // if (navigation.screenName == '/settings')
          //   const MaterialPage(child: SettingsScreen()),
          if (navigation.screenName == '/profile')
            const MaterialPage(child: ProfileScreen()),
        ],
        onPopPage: (route, result) {
          bool popStatus = route.didPop(result);
          if (popStatus == true) {
            Provider.of<NavigationController>(context, listen: false)
                .changeScreen('/');
          }
          return popStatus;
        },
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
