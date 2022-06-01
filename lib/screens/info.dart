import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justap/services/authentications.dart';
import 'package:provider/provider.dart';
import 'package:justap/utils/globals.dart' as globals;
import 'package:justap/components/bottom_nav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:justap/controllers/ro_media.dart';
import 'package:justap/components/ro_media_tile.dart';
import 'package:justap/controllers/user.dart';

class InfoScreen extends StatefulWidget {
  String? redirectURL;
  String? uid;

  InfoScreen({this.redirectURL, this.uid});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ROMediaController roMediaController = Get.put(ROMediaController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
                child: Column(children: [
              Container(
                  margin: const EdgeInsets.all(15.0),
                  // padding: const EdgeInsets.all(30.0),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: const Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(221, 105, 105, 105),
                              width: 3.0))),
                  child: Column(
                    children: <Widget>[
                      Container(child: Obx(() {
                        if (userController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Container(
                            height: 150,
                            child: userController.user().profileUrl != null
                                ? CircleAvatar(
                                    radius: 80,
                                    backgroundImage: NetworkImage(
                                        userController.user().profileUrl!),
                                  )
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/google_logo.png"),
                                  ),
                          );
                        }
                      })),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: Obx(() {
                          if (userController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (userController.user().nickName != null) {
                            return Text(
                              '${userController.user().nickName}',
                              style: const TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900),
                            );
                          } else {
                            return Text("");
                          }
                        }),
                      ),
                      Container(
                        child: Obx(() {
                          if (userController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (userController.user().email != null) {
                            return Text('${userController.user().email}',
                                style: const TextStyle(
                                    fontFamily: 'avenir',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500));
                          } else {
                            return Text("");
                          }
                        }),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 15, 15, 0),
                        child: Obx(() {
                          if (userController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (userController.user().introduction !=
                              null) {
                            return Text('${userController.user().introduction}',
                                style: const TextStyle(
                                    fontFamily: 'avenir',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500));
                          } else {
                            return Text("");
                          }
                        }),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Expanded(
                        child: Center(
                      child: Text(
                        'My Social Medias',
                        style: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 32,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (roMediaController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
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
            ]))));
  }
}
