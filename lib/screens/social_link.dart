import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:justap/components/bottom_nav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/components/media_tile.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/screens/create_media_dialog.dart';
import 'package:justap/widgets/cover_image.dart';
import 'package:justap/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialLink extends StatefulWidget {
  const SocialLink({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<SocialLink> createState() => _SocialLink();
}

class _SocialLink extends State<SocialLink> {
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: SizedBox(
            height: MediaQuery.of(context).size.height + 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: IconButton(
                          iconSize: 16,
                          alignment: Alignment.centerLeft,
                          //padding: const EdgeInsets.only(right: 00),
                          splashRadius: 4,
                          icon: const Icon(Icons.add_circle_outline, size: 16),
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
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Obx(() {
                    if (mediaController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return StaggeredGridView.countBuilder(
                        //crossAxisCount: 2,
                        crossAxisCount: 1,
                        itemCount: mediaController.mediaList.length,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        itemBuilder: (context, index) {
                          return MediaTile(
                              media: mediaController.mediaList[index]);
                        },
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(1),
                      );
                    }
                  }),
                )
              ],
            )));
  }
}
