import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:justap/components/business_reward_slide.dart';
import 'package:justap/components/reward_history_tile.dart';
import 'package:justap/components/reward_slides.dart';
import 'package:justap/controllers/business_image.dart';
import 'package:justap/controllers/reward_history.dart';
import 'package:justap/models/reward.dart';

class RewardDetailDialog extends StatefulWidget {
  Reward? reward;

  RewardDetailDialog({this.reward});

  @override
  _RewardDetailDialog createState() => _RewardDetailDialog();
}

class _RewardDetailDialog extends State<RewardDetailDialog> {
  void initState() {
    super.initState();
  }

  TextEditingController txt = TextEditingController();
  RewardHistoryController rewardHistoryController =
      Get.put(RewardHistoryController());
  BusinessImageController businessImageController =
      Get.put(BusinessImageController());

  Future<void> _pullRefresh() async {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      rewardHistoryController
          .fetchRewardHistory(widget.reward!.businessRewardId);
      businessImageController.fetchBusinessImage(widget.reward!.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      rewardHistoryController
          .fetchRewardHistory(widget.reward!.businessRewardId);
      businessImageController.fetchBusinessImage(widget.reward!.businessId);
    });

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(widget.reward!.businessRewardName!,
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: Container(
          margin: EdgeInsets.all(20.0),
          child: RefreshIndicator(
              onRefresh: _pullRefresh,
              displacement: 150,
              child: Column(
                children: [
                  Obx(() {
                    if (businessImageController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return BusinessRewardSlide(
                          businessImageList:
                              businessImageController.businessImageList);
                    }
                  }),
                  const SizedBox(height: 0),
                  Flexible(
                    child: Obx(() {
                      if (rewardHistoryController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return StaggeredGridView.countBuilder(
                          //crossAxisCount: 2,
                          crossAxisCount: 1,
                          itemCount:
                              rewardHistoryController.rewardHistoryList.length,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          itemBuilder: (context, index) {
                            return RewardHistoryTile(
                                rewardHistory: rewardHistoryController
                                    .rewardHistoryList[index]);
                          },
                          staggeredTileBuilder: (index) =>
                              const StaggeredTile.fit(1),
                        );
                      }
                    }),
                  )
                ],
              ))),
    );
  }
}
