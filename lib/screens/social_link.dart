import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/components/media_tile.dart';
import 'package:justap/screens/create_media_dialog.dart';

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
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          //height: 20.0,
                          //width: 20.0,
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  CreateMediaDialog(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ))
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
