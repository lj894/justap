import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/screens/visit_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      historyController.fetchHistory();
    });

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text("History", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: const TabBar(
              indicatorColor: Colors.black,
              tabs: <Widget>[
                Tab(
                    child:
                        Text("Visited", style: TextStyle(color: Colors.black))),
                Tab(
                    child:
                        Text("Tagged", style: TextStyle(color: Colors.black))),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              VisitHistoryTab(),
              // Center(
              //   child: Text("people who visited my page will appear here"),
              // ),
              Center(
                child: Text("people I recently visited will appear here"),
              ),
            ],
          ),
          bottomNavigationBar: const BottomNav(1),
        ));
  }
}
