import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/controllers/user.dart';
//import 'package:justap/screens/Image_upload.dart';
import 'package:justap/screens/social_link.dart';
import 'package:justap/screens/visit_history.dart';
import 'package:justap/widgets/cover_image.dart';
import 'package:justap/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  TabController? _tabController;
  String? token;

  final UserController userController = Get.put(UserController());
  final MediaController mediaController = Get.put(MediaController());
  final TabHistoryController historyController =
      Get.put(TabHistoryController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getToken();
  }

  getToken() async {
    token = await user?.getIdToken();
    setState(() {
      token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () async {
    //   historyController.fetchHistory();
    // });
    return Scaffold(
      bottomNavigationBar: const BottomNav(0),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                color: const Color.fromRGBO(235, 235, 235, 0.8),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                constraints: const BoxConstraints(
                    minHeight: 0, minWidth: double.infinity),
                child: SizedBox(
                    //height: MediaQuery.of(context).size.height,
                    child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      //alignment: Alignment.bottomLeft,
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         const ImageUpload(
                            //             title: "Upload Background Image",
                            //             type: "BACKGROUND"),
                            //     fullscreenDialog: true,
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Obx(() {
                              if (userController.isLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (userController.user().backgroundUrl !=
                                    null) {
                                  return CoverImage(
                                      userController.user().backgroundUrl);
                                } else {
                                  return CoverImage(null);
                                }
                              }
                            }),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          //left: 10,
                          child: Obx(() {
                            if (userController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return userController.user().profileUrl == null
                                  ? InkWell(
                                      onTap: () async {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute<void>(
                                        //     builder: (BuildContext context) =>
                                        //         const ImageUpload(
                                        //             title:
                                        //                 "Upload Profile Photo",
                                        //             type: "PROFILE"),
                                        //     fullscreenDialog: true,
                                        //   ),
                                        // );
                                      },
                                      child: DefaultProfileImage())
                                  : InkWell(
                                      onTap: () async {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute<void>(
                                        //     builder: (BuildContext context) =>
                                        //         const ImageUpload(
                                        //             title:
                                        //                 "Upload Profile Photo",
                                        //             type: "PROFILE"),
                                        //     fullscreenDialog: true,
                                        //   ),
                                        // );
                                      },
                                      child: ProfileImage(
                                          userController.user().profileUrl));
                            }
                          }),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (userController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (userController.user().nickName != null) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 10,
                              //bottom: 20,
                              //right: 20,
                              top: 1),
                          child: Text(
                            userController.user().nickName!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
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
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 10,
                              //bottom: 20,
                              //right: 20,
                              top: 1),
                          child: Text(
                            userController.user().introduction!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 14,
                                color: Colors.black45,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      } else {
                        return const Text("");
                      }
                    }),
                  ],
                ))),
            ButtonsTabBar(
              backgroundColor: Colors.black,
              unselectedBackgroundColor: Colors.white,
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              borderWidth: 1,
              unselectedBorderColor: Colors.black87,
              radius: 100,
              height: 24,
              buttonMargin: const EdgeInsets.only(top: 5, left: 20, right: 20),
              tabs: const [
                Tab(
                  text: 'Social Links',
                  height: 20.0,
                ),
                Tab(
                  text: 'Tab History',
                  height: 20.0,
                )
              ],
              controller: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [SocialLink(), VisitTabHistoryTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
