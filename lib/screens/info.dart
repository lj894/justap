import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:justap/controllers/ro_media.dart';
import 'package:justap/components/ro_media_tile.dart';
import 'package:justap/controllers/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:justap/widgets/cover_image.dart';
import 'package:justap/widgets/profile_image.dart';

class InfoScreen extends StatefulWidget {
  String? redirectURL;
  String? uid;

  InfoScreen({this.redirectURL, this.uid});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  var token;

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

  final ROMediaController roMediaController = Get.put(ROMediaController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser?.getIdToken().then((value) {
        globals.userToken = value;
      });
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              //child: FloatingActionButton.extended(
              child: FloatingActionButton(
                mini: true,
                tooltip: token == null ? "Sign In" : "Back",
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(Uri.base.origin))) {
                    await launchUrl(Uri.parse(Uri.base.origin));
                  }
                },
                child: token == null
                    ? const Icon(Icons.login_rounded)
                    : const Icon(Icons.arrow_back),
              ),
            )),
        floatingActionButtonLocation: token == null
            ? FloatingActionButtonLocation.miniEndTop
            : FloatingActionButtonLocation.miniStartTop,
        body: Container(
            margin: EdgeInsets.all(20.0),
            //child: SingleChildScrollView(
            //reverse: true,
            child: SizedBox(
                height: MediaQuery.of(context).size.height + 100,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        CoverImage(true),
                        Positioned(
                          top: 80,
                          child: Obx(() {
                            if (userController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return userController.user().profileUrl == null
                                  ? DefaultProfileImage()
                                  : ProfileImage(
                                      userController.user().profileUrl);
                            }
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Obx(() {
                      if (userController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (userController.user().nickName != null) {
                        return Text(
                          '${userController.user().nickName}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        );
                      } else {
                        return const Text("");
                      }
                    }),
                    const SizedBox(height: 8),
                    Obx(() {
                      if (userController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (userController.user().introduction != null) {
                        return Text(
                          '${userController.user().introduction}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400),
                        );
                      } else {
                        return const Text("");
                      }
                    }),
                    //const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Center(
                            child: Text(
                              'My Social Links',
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(() {
                        if (roMediaController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: roMediaController.ro_mediaList.length,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            itemBuilder: (context, index) {
                              return ROMediaTile(
                                  roMediaController.ro_mediaList[index]);
                            },
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(1),
                          );
                        }
                      }),
                    )
                  ],
                )))
        //)
        );
  }
}
