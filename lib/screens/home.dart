import 'package:flutter/material.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/components/media_tile.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/screens/create_media_dialog.dart';

class HomeScreen extends StatelessWidget {
  final MediaController mediaController = Get.put(MediaController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      mediaController.fetchMedias();
      userController.fetchUser();
    });

    return Scaffold(
        appBar: AppBar(
          //title: const Text("Home"),
          backgroundColor: Colors.white,
          toolbarHeight: 0,
        ),
        bottomNavigationBar: const BottomNav(0),
        body: Column(
          children: [
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
            Expanded(
              child: Obx(() {
                if (mediaController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: mediaController.mediaList.length,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return MediaTile(mediaController.mediaList[index]);
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  );
                }
              }),
            )
          ],
        ));
  }
}
