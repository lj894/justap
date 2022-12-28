import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/screens/wallet.dart';
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
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseAuth.instance.currentUser
        ?.getIdToken()
        .then((value) => globals.userToken = value);
  }
  runApp(JusTap(redirectURL: redirectURL, code: code));
}

class JusTap extends StatefulWidget {
  String? redirectURL;
  String? code;

  JusTap({this.redirectURL, this.code});

  @override
  _JusTapState createState() => _JusTapState();
}

class _JusTapState extends State<JusTap> {
  @override
  Widget build(BuildContext context) {
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
                return (widget.code != null)
                    ? MaterialApp(
                        title: 'JusTap',
                        initialRoute: "/user/${widget.code}",
                        routes: <String, WidgetBuilder>{
                          "/user/${widget.code}": (context) => InfoScreen(
                              redirectURL: widget.redirectURL,
                              code: widget.code),
                          "/?code=${widget.code}": (context) => InfoScreen(
                              redirectURL: widget.redirectURL,
                              code: widget.code),
                        },
                        home: InfoScreen(
                            redirectURL: widget.redirectURL, code: widget.code))
                    : (snapshot.data != null)
                        ? const AuthenticationWrapper()
                        : LoginScreen();
              }
            }));
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
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
          MaterialPage(child: RewardScreen()),
          if (navigation.screenName == '/wallet')
            const MaterialPage(child: WalletScreen()),
          if (navigation.screenName == '/social')
            MaterialPage(child: HomeScreen()),
          if (navigation.screenName == '/reward_exchange')
            const MaterialPage(child: RewardExchangeScreen()),
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
