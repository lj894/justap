import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/components/media_tile.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/screens/create_media_dialog.dart';
import 'package:justap/widgets/cover_image.dart';
import 'package:justap/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      mediaController.fetchMedias();
      userController.fetchUser();
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
        ),
        bottomNavigationBar: const BottomNav(0),
        body: Container(
            margin: const EdgeInsets.all(20.0),
            child: SizedBox(
                height: MediaQuery.of(context).size.height + 100,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      //alignment: Alignment.bottomLeft,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Obx(() {
                            if (userController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              if (userController.user().backgroundUrl != null) {
                                return CoverImage(
                                    userController.user().backgroundUrl);
                              } else {
                                return CoverImage(null);
                              }
                            }
                          }),
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
                                  ? DefaultProfileImage()
                                  : ProfileImage(
                                      userController.user().profileUrl);
                            }
                          }),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 24),
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
                            utf8.decode(
                                userController.user().nickName!.runes.toList()),
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
                            utf8.decode(userController
                                .user()
                                .introduction!
                                .runes
                                .toList()),
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
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Social Links',
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      CreateMediaDialog(),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                          //IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                          //IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Obx(() {
                        if (mediaController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return StaggeredGridView.countBuilder(
                            //crossAxisCount: 2,
                            crossAxisCount: 1,
                            itemCount: mediaController.mediaList.length,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            itemBuilder: (context, index) {
                              return MediaTile(
                                  media: mediaController.mediaList[index]);
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1),
                          );
                        }
                      }),
                    )
                  ],
                ))));
  }
}
