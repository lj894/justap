import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/components/offer_tile.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/models/offer.dart';

class RewardOfferTab extends StatefulWidget {
  const RewardOfferTab({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<RewardOfferTab> createState() => _RewardOfferTab();
}

class _RewardOfferTab extends State<RewardOfferTab> {
  final offerList = offerFromJson(
      '[{"id": 1, "user": "Lee", "userImage": "", "offerStore": "Bubble Tea", "offerCredit": 5, "askingStore": "Noddle House", "askingCredit": 4, "createdAt": 1657194538925, "expiryAt": 1657994538925}, {"id": 2, "user": "Jas", "userImage": "", "offerStore": "Noddle House", "offerCredit": 2, "askingStore": "Bubble Tea", "askingCredit": 2, "createdAt": 1657194538925, "expiryAt": 1657994538925}]');
  final HistoryController historyController = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Flexible(
          child: Obx(() {
            if (historyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 1,
                itemCount: offerList.length,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                itemBuilder: (context, index) {
                  return OfferTile(
                      offer: offerList[
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
