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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'My Portfolios',
                          style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 32,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
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
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      );
                    }
                  }),
                )
              ],
            )));
  }
}
