import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:justap/screens/all.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:url_strategy/url_strategy.dart';
import 'controllers/navigation.dart';

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
    if (widget.uid != null) {
      return MaterialApp(
          initialRoute: "/?uid=${widget.uid}",
          routes: <String, WidgetBuilder>{
            "/?uid=${widget.uid}": (context) =>
                InfoScreen(redirectURL: widget.redirectURL, uid: widget.uid),
          },
          home: InfoScreen(redirectURL: widget.redirectURL, uid: widget.uid));
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
        child: const AuthenticationWrapper(),
      );
    }
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    NavigationController navigation =
        Provider.of<NavigationController>(context);

    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser
          ?.getIdToken()
          .then((value) => globals.userToken = value);
    }

    if (user != null) {
      return MaterialApp(
        initialRoute: "/",
        home: Navigator(
          pages: [
            MaterialPage(child: HomeScreen()),
            if (navigation.screenName == '/settings')
              const MaterialPage(child: SettingsScreen()),
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
    return LoginScreen();
  }
}
