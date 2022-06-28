import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:justap/components/history_tile.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';

class VisitHistoryTab extends StatefulWidget {
  const VisitHistoryTab({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<VisitHistoryTab> createState() => _VisitHistoryTab();
}

class _VisitHistoryTab extends State<VisitHistoryTab> {
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
                //crossAxisCount: 2,
                crossAxisCount: 1,
                itemCount: historyController.historyList.length,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                itemBuilder: (context, index) {
                  return HistoryTile(
                      history: historyController.historyList[index]);
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
