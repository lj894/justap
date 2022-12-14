import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/screens/qr_code.dart';
import 'package:justap/services/authentications.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:justap/controllers/navigation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  var token;
  var nickName = "";
  var introduction = "";
  var nnChanged = false;
  var irChanged = false;

  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    token = await user?.getIdToken();
    setState(() {
      token = token;
    });
  }

  void _ndefWrite() async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    if (Platform.isAndroid) {
      showNFCScanDialog(
          context,
          () => () {
                NfcManager.instance.stopSession();
              });

      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);
        if (ndef == null || !ndef.isWritable) {
          result.value = 'Tag is not ndef writable';
          NfcManager.instance.stopSession(errorMessage: result.value);
          return;
        }

        NdefMessage message = NdefMessage([
          NdefRecord.createUri(Uri.parse(
              "https://app.justap.us/user/${userController.user().code}")),
        ]);

        try {
          await ndef.write(message);
          result.value = 'Success to "Ndef Write"';
          Navigator.of(context, rootNavigator: true).pop();
          showAlertDialog(context, "Done", "You are all set!");
          NfcManager.instance.stopSession();
        } catch (e) {
          result.value = e;
          NfcManager.instance
              .stopSession(errorMessage: result.value.toString());
          return;
        }
      });
    }

    if (Platform.isIOS)
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);
        if (ndef == null || !ndef.isWritable) {
          result.value = 'Tag is not ndef writable';
          NfcManager.instance.stopSession(errorMessage: result.value);
          return;
        }

        NdefMessage message = NdefMessage([
          //NdefRecord.createText('JusTap'),
          NdefRecord.createUri(Uri.parse(
              "https://app.justap.us/user/${userController.user().code}")),
          // NdefRecord.createMime(
          //     'text/plain', Uint8List.fromList('JusTap'.codeUnits)),
          // NdefRecord.createExternal(
          //     'us.justap', 'justap', Uint8List.fromList('JusTap'.codeUnits)),
        ]);

        try {
          await ndef.write(message);
          result.value = 'Success to "Ndef Write"';
          NfcManager.instance.stopSession();
        } catch (e) {
          result.value = e;
          NfcManager.instance
              .stopSession(errorMessage: result.value.toString());
          return;
        }
      });
  }

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: GestureDetector(
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse("http://justap.us"))) {
                    await launchUrl(Uri.parse("http://justap.us"));
                  }
                },
                child: const Image(
                  image: AssetImage("assets/images/site_logo.png"),
                  width: 80.0,
                )),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        bottomNavigationBar: const BottomNav(3),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              mini: true,
              tooltip: "Sign Out",
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Provider.of<NavigationController>(context, listen: false)
                    .changeScreen('/');
                setState(() {});
              },
              child: Image.asset("assets/images/LOGOUT_ICON.png",
                  width: 30, height: 30),
            )),
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("My Profile",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              initialValue: userController.user().nickName,
                              maxLength: 30,
                              onChanged: (value) {
                                setState(() {
                                  nnChanged = true;
                                  nickName = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Nick Name',
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              initialValue: userController.user().introduction,
                              maxLength: 255,
                              onChanged: (value) {
                                setState(() {
                                  irChanged = true;
                                  introduction = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Introduction',
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.grey)),
                                primary: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text("SAVE"),
                            onPressed: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var nn = "", ir = "";
                              if (nnChanged) {
                                nn = nickName;
                              } else if (userController.user().nickName !=
                                  null) {
                                nn = userController.user().nickName!;
                              }
                              if (irChanged) {
                                ir = introduction;
                              } else if (userController.user().introduction !=
                                  null) {
                                ir = userController.user().introduction!;
                              }
                              await RemoteServices.updateProfile(nn, ir);
                              showAlertDialog(context, "Update Profile",
                                  "You have sucessfully updated your profile!");
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Obx(() {
                            if (userController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (userController.user().code != null) {
                              return IconButton(
                                iconSize: 24.0,
                                icon: const Icon(Icons.qr_code_rounded),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          QRCodeDialog(
                                              qrString:
                                                  userController.user().code),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return IconButton(
                                iconSize: 24.0,
                                icon: const Icon(Icons.copy_all_outlined),
                                color: Colors.black,
                                onPressed: () {},
                              );
                            }
                          }),
                          Obx(() {
                            if (userController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (userController.user().code != null) {
                              return IconButton(
                                iconSize: 24.0,
                                icon: const Icon(Icons.copy_all_outlined),
                                color: Colors.black,
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          "https://app.justap.us/user/${userController.user().code}"));
                                  showAlertDialog(context, "Copy Link",
                                      "Link copied! You can write it to a NFC tag and share with others.");
                                },
                              );
                            } else {
                              return IconButton(
                                iconSize: 24.0,
                                icon: const Icon(Icons.copy_all_outlined),
                                color: Colors.black,
                                onPressed: () {},
                              );
                            }
                          }),
                          Obx(() {
                            if (userController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (userController.user().code != null) {
                              return Expanded(
                                  child: TextFormField(
                                //cursorColor: Theme.of(context).cursorColor,
                                initialValue:
                                    "https://app.justap.us/user/${userController.user().code}",
                                style: const TextStyle(color: Colors.black45),
                                readOnly: true,
                                enabled: false,
                                decoration: const InputDecoration(
                                  labelText: 'My Link',
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ));
                            } else {
                              return Expanded(
                                  child: TextFormField(
                                //cursorColor: Theme.of(context).cursorColor,
                                initialValue: "loading...",
                                style: const TextStyle(color: Colors.black45),
                                readOnly: true,
                                enabled: false,
                                decoration: const InputDecoration(
                                  labelText: 'My URL',
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ));
                            }
                          }),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Lost your tag? Reset your link and activate your new tag!",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.grey)),
                                primary: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            child: const Text("RESET LINK"),
                            onPressed: () async {
                              showConfirmDialog(
                                  context,
                                  "Reset Code",
                                  "Are you sure you wish to reset your personal code? \nYou can't undo this operation afterwards and all your tags with the old code needs to rewrite.",
                                  () => () async {
                                        await RemoteServices.resetProfileCode();
                                        userController.fetchUser();
                                        setState(() {});
                                      });
                            },
                          ),
                          if (!kIsWeb)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side:
                                          const BorderSide(color: Colors.grey)),
                                  primary: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              child: const Text("ACTIVATE TAG"),
                              onPressed: () async {
                                _ndefWrite();
                              },
                            )
                        ],
                      ),
                      //const SizedBox(height: 24),
                    ])),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Colors.white;
                                    }
                                    return null;
                                  },
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Colors.black;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              onPressed: () async {
                                showConfirmDialog(
                                    context,
                                    "Delete Account",
                                    "Are you sure you wish to delete your JusTap account permanently? \nBefore deleting your account, you should keep in mind that it will also permanently remove your link, and erase your entire tap history.\nYour tag will no longer functional as well.",
                                    () => () async {
                                          RemoteServices.deleteUser();
                                          context
                                              .read<AuthenticationService>()
                                              .signOut();
                                          Provider.of<NavigationController>(
                                                  context,
                                                  listen: false)
                                              .changeScreen('/');
                                          setState(() {});
                                        });
                              },
                              child: const Text('DELETE ACCOUNT',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10)),
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
