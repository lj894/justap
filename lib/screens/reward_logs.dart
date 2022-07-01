import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/components/reward_log_tile.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/models/reward_log.dart';

class RewardLogsTab extends StatefulWidget {
  const RewardLogsTab({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<RewardLogsTab> createState() => _RewardLogsTab();
}

class _RewardLogsTab extends State<RewardLogsTab> {
  final rewardLogList = rewardLogFromJson(
      '[{"id": 1, "message": "Your offer has been submitted successfully.", "createdAt": 1657194538925}, {"id": 2, "message": "Your trade for 4 Bubble Tea pts with 5 Noddle House pts has finished.", "createdAt": 1657194538925}]');
  final TabHistoryController historyController =
      Get.put(TabHistoryController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 5),
        Flexible(
          child: Obx(() {
            if (historyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 1,
                itemCount: rewardLogList.length,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                itemBuilder: (context, index) {
                  return RewardLogTile(
                      rewardLog: rewardLogList[
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
