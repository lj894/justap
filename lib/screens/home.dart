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
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                reverse: true,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height + 100,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            CoverImage(),
                            Positioned(
                              top: 80,
                              child: Obx(() {
                                if (userController.isLoading.value) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return userController.user().profileUrl ==
                                          null
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
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (userController.user().nickName != null) {
                            return Text(
                              '${userController.user().nickName}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800),
                            );
                          } else {
                            return const Text("");
                          }
                        }),
                        const SizedBox(height: 8),
                        Obx(() {
                          if (userController.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (userController.user().nickName != null) {
                            return Text(
                              '${userController.user().introduction}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w800),
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
                                  'My Portfolios',
                                  style: TextStyle(
                                      fontFamily: 'avenir',
                                      fontSize: 32,
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
                                crossAxisCount: 2,
                                itemCount: mediaController.mediaList.length,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                itemBuilder: (context, index) {
                                  return MediaTile(
                                      mediaController.mediaList[index]);
                                },
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.fit(1),
                              );
                            }
                          }),
                        )
                      ],
                    )))));
  }
}
