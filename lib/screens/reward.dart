import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:justap/components/reward_slides.dart';
import 'package:justap/components/reward_list.dart';
import 'package:justap/models/reward.dart';

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
  //final RewardController rewardController = Get.put(RewardController());

  final rewardList = rewardFromJson(
      '[{"id": 1, "store": "Bubble Tea", "type": "TEA", "image": "", "credit": 8, "fullCredit": 10, "expiryAt": 1657294538925},{"id": 2, "store": "Noddle House", "type": "FOOD", "image": "", "credit": 2, "fullCredit": 5, "expiryAt": 1656994538925}]');

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      //rewardController.fetchReward();
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text("Reward", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      // floatingActionButton: Padding(
      //     padding: const EdgeInsets.only(top: 30.0),
      //     //child: FloatingActionButton.extended(
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.black,
      //       mini: true,
      //       tooltip: "Reward History",
      //       onPressed: () {
      //         // context.read<AuthenticationService>().signOut();
      //         // Provider.of<NavigationController>(context, listen: false)
      //         //     .changeScreen('/');
      //         // setState(() {});
      //       },
      //       child: const Icon(Icons.history_rounded),
      //     )),
      body: Column(
        children: [
          const RewardSlides(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                child: const Icon(
                  Icons.history_rounded,
                  color: Colors.black,
                ),
                onPressed: () async {},
              )
            ],
          ),
          //const SizedBox(height: 5),
          Flexible(
              child:
                  //Obx(() {
                  //if (historyController.isLoading.value) {
                  //return const Center(child: CircularProgressIndicator());
                  //} else {
                  //return
                  StaggeredGridView.countBuilder(
            //crossAxisCount: 2,
            crossAxisCount: 1,
            itemCount:
                rewardList.length, //historyController.historyList.length,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            itemBuilder: (context, index) {
              return RewardTile(
                  reward: rewardList[
                      index]); //historyController.historyList[index]);
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          )
              //}
              //}),
              //))
              )
        ],
      ),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}
