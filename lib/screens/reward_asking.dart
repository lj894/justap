import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/components/asking_tile.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/models/offer.dart';

class RewardAskingTab extends StatefulWidget {
  const RewardAskingTab({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<RewardAskingTab> createState() => _RewardAskingTab();
}

class _RewardAskingTab extends State<RewardAskingTab> {
  final askingList = offerFromJson(
      '[{"id": 1, "user": "Lee", "userImage": "", "offerStore": "Bubble Tea", "offerCredit": 5, "askingStore": "Noddle House", "askingCredit": 4, "createdAt": 1657194538925, "expiryAt": 1657994538925, "status": "Active"}, {"id": 2, "user": "Jas", "userImage": "", "offerStore": "Noddle House", "offerCredit": 2, "askingStore": "Bubble Tea", "askingCredit": 2, "createdAt": 1657194538925, "expiryAt": 1657994538925, "status": "Active"}]');
  final HistoryController historyController = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: SizedBox(
              //height: 20.0,
              //width: 20.0,
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.black,
            ),
            onPressed: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) =>
              //         CreateMediaDialog(),
              //     fullscreenDialog: true,
              //   ),
              // );
            },
          )),
        ),
        Flexible(
          child: Obx(() {
            if (historyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 1,
                itemCount: askingList.length,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                itemBuilder: (context, index) {
                  return AskingTile(
                      asking: askingList[
                          index]); //offerController.offerList[index]);
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              );
            }
          }),
        )
      ],
    );
  }
}
