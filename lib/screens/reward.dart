import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:justap/components/reward_slides.dart';
import 'package:justap/components/reward_tile.dart';
import 'package:justap/controllers/reward.dart';
import 'package:justap/controllers/user.dart';
import 'package:justap/models/reward.dart';
import 'package:justap/screens/qr_code.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<RewardScreen> createState() => _RewardScreen();
}

class _RewardScreen extends State<RewardScreen> {
  final RewardController rewardController = Get.put(RewardController());
  final UserController userController = Get.put(UserController());

  Future<void> _pullRefresh() async {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      rewardController.fetchRewards();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      rewardController.fetchRewards();
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse("http://justap.us"))) {
                await launchUrl(Uri.parse("http://justap.us"));
              }
            },
            child: const Image(
              image: AssetImage("assets/images/site_logo.png"),
              width: 80.0,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black87,
            elevation: 0.0,
            mini: true,
            tooltip: "QR Code",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      QRCodeDialog(qrString: userController.user().code),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Icon(Icons.qr_code_rounded),
          )),
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          displacement: 150,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("My Rewards",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                ],
              ),
              const RewardSlides(),
              Flexible(
                child: Obx(() {
                  if (rewardController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return StaggeredGridView.countBuilder(
                      //crossAxisCount: 2,
                      crossAxisCount: 1,
                      itemCount: rewardController.rewardList.length,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      itemBuilder: (context, index) {
                        return RewardTile(
                            reward: rewardController.rewardList[index]);
                      },
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                    );
                  }
                }),
              )
            ],
          )),
      bottomNavigationBar: const BottomNav(0),
    );
  }
}
