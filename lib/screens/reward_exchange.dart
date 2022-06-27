import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/screens/visit_history.dart';

class RewardExchangeScreen extends StatefulWidget {
  const RewardExchangeScreen({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<RewardExchangeScreen> createState() => _RewardExchangeScreen();
}

class _RewardExchangeScreen extends State<RewardExchangeScreen> {
  //final RewardController rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      //rewardController.fetchReward();
    });

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text("Reward Exchange",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: ButtonsTabBar(
              backgroundColor: Colors.black,
              unselectedBackgroundColor: Colors.white,
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              borderWidth: 1,
              unselectedBorderColor: Colors.black87,
              radius: 100,
              height: 40,
              buttonMargin: const EdgeInsets.only(
                  top: 10, left: 30, right: 30, bottom: 10),
              tabs: const <Widget>[
                Tab(
                  //child: SizedBox(width: 100, child: Text('Sell')),
                  text: "Buy",
                  height: 40.0,
                ),
                Tab(
                  //child: SizedBox(width: 100, child: Text('Sell')),
                  text: "Sell",
                  height: 40.0,
                ),
                Tab(
                  //child: SizedBox(width: 100, child: Text('Message')),
                  text: "Message",
                  height: 40.0,
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: Text("Buy"),
              ),
              Center(
                child: Text("Sell"),
              ),
              Center(
                child: Text("Message"),
              ),
            ],
          ),
          bottomNavigationBar: const BottomNav(2),
        ));
  }
}
