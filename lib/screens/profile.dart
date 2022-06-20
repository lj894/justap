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
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text("Profile", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        bottomNavigationBar: const BottomNav(1),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 60.0),
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
            margin: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      //alignment: Alignment.bottomLeft,
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ImageUpload(
                                        title: "Upload Background Image",
                                        type: "BACKGROUND"),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Container(
                              height: 120,
                              margin: const EdgeInsets.only(bottom: 5),
                              color: Colors.grey,
                              child: userController.user().backgroundUrl != null
                                  ? Image.network(
                                      userController.user().backgroundUrl!,
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/profile_background.png",
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        Positioned(
                          top: 60,
                          //left: 10,
                          child: Obx(() {
                            if (userController.isLoading.value) {
                              return ProfileWidget(
                                imagePath:
                                    "assets/images/avatar_placeholder.png",
                                isEdit: true,
                                onClicked: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ImageUpload(
                                              title: "Upload Profile Photo",
                                              type: "PROFILE"),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return ProfileWidget(
                                imagePath: userController.user().profileUrl !=
                                        null
                                    ? userController.user().profileUrl!
                                    : "assets/images/avatar_placeholder.png",
                                isEdit: true,
                                onClicked: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ImageUpload(
                                              title: "Upload Profile Photo",
                                              type: "PROFILE"),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('${user?.email}',
                        style: const TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 10,
                            fontWeight: FontWeight.w500)),
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
                                        "${Uri.base}?code=${userController.user().code}"));
                                showAlertDialog(context, "Copy URL",
                                    "URL copied! You can write it to a NFC tag and share with others.");
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
                                  "${Uri.base}?code=${userController.user().code}",
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
                      children: [
                        const Text(
                          "Lost your tag? Let's ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
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
                          child: const Text(
                            "Reset Your Code",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
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
                            initialValue: utf8.decode(
                                userController.user().nickName!.runes.toList()),
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
                            initialValue: utf8.decode(userController
                                .user()
                                .introduction!
                                .runes
                                .toList()),
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
                  ],
                ))));
  }
}
