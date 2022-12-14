import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/ro_media.dart';
import 'package:justap/components/ro_media_tile.dart';
import 'package:justap/controllers/ro_user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:justap/widgets/background_image.dart';
import 'package:justap/widgets/profile_widget.dart';
import 'package:justap/services/remote_services.dart';

class InfoScreen extends StatefulWidget {
  String? redirectURL;
  String? code;

  InfoScreen({this.redirectURL, this.code});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

bool isLogged = false;

class _InfoScreenState extends State<InfoScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  var token;

  @override
  void initState() {
    super.initState();
    if (isLogged == false) {
      isLogged = true;
      RemoteServices.logProfileVisit(widget.code);
    }
    getToken();
  }

  getToken() async {
    token = await user?.getIdToken();
    setState(() {
      token = token;
    });
  }

  final ROMediaController roMediaController = Get.put(ROMediaController());
  final ROUserController roUserController = Get.put(ROUserController());

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser?.getIdToken().then((value) {
        globals.userToken = value;
      });
    }
    return Obx(() {
      if (roUserController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        if (roUserController.user().code != null) {
          return Stack(children: <Widget>[
            Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 40,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
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
                ),
                body: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
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
                                Container(
                                  height: 120,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Obx(() {
                                    if (roUserController.isLoading.value) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      if (roUserController
                                              .user()
                                              .backgroundUrl !=
                                          null) {
                                        return CoverImage(roUserController
                                            .user()
                                            .backgroundUrl);
                                      } else {
                                        return CoverImage(null);
                                      }
                                    }
                                  }),
                                ),
                                Positioned(
                                  top: 80,
                                  child: Obx(() {
                                    if (roUserController.isLoading.value) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      return roUserController
                                                  .user()
                                                  .profileUrl ==
                                              null
                                          ? DefaultProfileImage()
                                          : ProfileImage(roUserController
                                              .user()
                                              .profileUrl);
                                    }
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Obx(() {
                              if (roUserController.isLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (roUserController.user().nickName !=
                                  null) {
                                return Text(
                                  roUserController.user().nickName!,
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
                              if (roUserController.isLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (roUserController.user().introduction !=
                                  null) {
                                return Text(
                                  roUserController.user().introduction!,
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
                                    itemCount:
                                        roMediaController.ro_mediaList.length,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    itemBuilder: (context, index) {
                                      return ROMediaTile(
                                          roMediaController.ro_mediaList[index],
                                          widget.code);
                                    },
                                    staggeredTileBuilder: (index) =>
                                        const StaggeredTile.fit(1),
                                  );
                                }
                              }),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom)),
                          ],
                        )))
                //)
                ),
            token == null
                ? Positioned(
                    top: 0,
                    right: 15.0,
                    child: FloatingActionButton(
                      backgroundColor:
                          token == null ? Colors.transparent : Colors.black,
                      mini: true,
                      tooltip: token == null ? "Sign In" : "Back",
                      onPressed: () async {
                        if (await canLaunchUrl(Uri.parse(Uri.base.origin))) {
                          await launchUrl(Uri.parse(Uri.base.origin),
                              webOnlyWindowName: '_self');
                        }
                      },
                      child: token == null
                          ? Image.asset("assets/images/LOGOUT_ICON.png",
                              width: 30, height: 30)
                          : const Icon(Icons.arrow_back),
                    ),
                  )
                : Positioned(
                    top: 0,
                    left: 15.0,
                    child: FloatingActionButton(
                      backgroundColor:
                          token == null ? Colors.transparent : Colors.black,
                      mini: true,
                      tooltip: token == null ? "Sign In" : "Back",
                      onPressed: () async {
                        if (await canLaunchUrl(Uri.parse(Uri.base.origin))) {
                          await launchUrl(Uri.parse(Uri.base.origin),
                              webOnlyWindowName: '_self');
                        }
                      },
                      child: token == null
                          ? Image.asset("assets/images/LOGOUT_ICON.png",
                              width: 30, height: 30)
                          : const Icon(Icons.arrow_back),
                    ),
                  ),
          ]);
        } else {
          return Container();
        }
      }
    });
  }
}
