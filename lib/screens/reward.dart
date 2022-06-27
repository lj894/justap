import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/screens/visit_history.dart';

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
      body: const Center(child: Text("Reward")),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}
