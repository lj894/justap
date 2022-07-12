import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/components/history_tile.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';

class VisitTabHistoryTab extends StatefulWidget {
  const VisitTabHistoryTab({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<VisitTabHistoryTab> createState() => _VisitTabHistoryTab();
}

class _VisitTabHistoryTab extends State<VisitTabHistoryTab> {
  final TabHistoryController historyController =
      Get.put(TabHistoryController());

  Future<void> _pullRefresh() async {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      historyController.fetchTabHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      historyController.fetchTabHistory();
    });
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Column(
          children: [
            const SizedBox(height: 0),
            Flexible(
              child: Obx(() {
                if (historyController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return StaggeredGridView.countBuilder(
                    //crossAxisCount: 2,
                    crossAxisCount: 1,
                    itemCount: historyController.historyList.length,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    itemBuilder: (context, index) {
                      return TabHistoryTile(
                          history: historyController.historyList[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  );
                }
              }),
            )
          ],
        ));
  }
}
