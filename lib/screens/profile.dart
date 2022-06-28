import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/screens/Image_upload.dart';
import 'package:justap/services/authentications.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/widgets/profile_widget.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:justap/controllers/navigation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            //child: FloatingActionButton.extended(
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              mini: true,
              tooltip: "Sign Out",
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Provider.of<NavigationController>(context, listen: false)
                    .changeScreen('/');
                setState(() {});
              },
              child: const Icon(Icons.logout_rounded),
            )),
        body: Container(
            margin: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
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
                            cursorColor: Theme.of(context).cursorColor,
                            initialValue: userController.user().nickName!,
                            //maxLength: 50,
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
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            cursorColor: Theme.of(context).cursorColor,
                            initialValue: userController.user().introduction,
                            //minLines: 5,
                            maxLines: 4,
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
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom)),
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
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          child: const Text("Save"),
                          onPressed: () async {
                            var nn = "", ir = "";
                            if (nnChanged) {
                              nn = nickName;
                            } else if (userController.user().nickName != null) {
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
                              icon: const Icon(Icons.copy_all_outlined),
                              color: Colors.black,
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        "${Uri.base}user/${userController.user().code}"));
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
                              cursorColor: Theme.of(context).cursorColor,
                              initialValue:
                                  "${Uri.base}user/${userController.user().code}",
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
                              cursorColor: Theme.of(context).cursorColor,
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
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          child: const Text("Reset Link"),
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          child: const Text("Activate Tag"),
                          onPressed: () async {},
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
