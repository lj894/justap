import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/media.dart';
import 'package:justap/components/media_tile.dart';
import 'package:justap/screens/create_media_dialog.dart';
import 'package:justap/services/remote_services.dart';

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
                      return ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;
                            final item =
                                mediaController.mediaList.removeAt(oldIndex);
                            mediaController.mediaList.insert(newIndex, item);
                            var data = [];
                            for (var i = 0;
                                i < mediaController.mediaList.length;
                                i++) {
                              mediaController.mediaList[i]?.sequence = i;
                              data.add({
                                "id": mediaController.mediaList[i]?.id,
                                "sequence":
                                    mediaController.mediaList[i]?.sequence
                              });
                            }
                            RemoteServices.updateMediaSequence(data);
                          });
                        },
                        children: [
                          for (final mediaItem in mediaController.mediaList)
                            Card(
                                key: ValueKey(mediaItem),
                                elevation: 1,
                                child: MediaTile(media: mediaItem)),
                        ],
                      );
                    }
                  }),
                )
              ],
            )));
  }
}
