import 'package:flutter/material.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justap/services/authentications.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/widgets/profile_widget.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:justap/controllers/navigation.dart';

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
        appBar: AppBar(title: const Text("Profile")),
        bottomNavigationBar: const BottomNav(2),
        //floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FloatingActionButton.extended(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Provider.of<NavigationController>(context, listen: false)
                    .changeScreen('/');
                setState(() {});
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text("Sign Out")),
        ),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    ProfileWidget(
                      imagePath: (user != null && user?.photoURL != null)
                          ? user!.photoURL!
                          : "https://toppng.com/uploads/preview/roger-berry-avatar-placeholder-11562991561rbrfzlng6h.png",
                      isEdit: true,
                      onClicked: () async {},
                    ),
                    const SizedBox(height: 12),
                    Text('${user?.email}',
                        style: const TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 10,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            cursorColor: Theme.of(context).cursorColor,
                            initialValue: userController.user().nickName,
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
                                color: Color(0xFF6200EE),
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
                            maxLines: 5,
                            onChanged: (value) {
                              setState(() {
                                irChanged = true;
                                introduction = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Introduction',
                              labelStyle: TextStyle(
                                color: Color(0xFF6200EE),
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
                              //primary: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 56, vertical: 20),
                              textStyle: TextStyle(
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
