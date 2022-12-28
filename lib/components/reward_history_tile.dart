import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/reward_history.dart';
import 'package:justap/screens/reward_detail_dialog.dart';

class RewardHistoryTile extends StatefulWidget {
  final RewardHistory? rewardHistory;

  const RewardHistoryTile({this.rewardHistory});

  @override
  _RewardHistoryTile createState() => _RewardHistoryTile();
}

class _RewardHistoryTile extends State<RewardHistoryTile> {
  get $d24 => null;

  @override
  void initState() {
    super.initState();
  }

  getRewardDate(context, reward) {
    var exp = widget.rewardHistory!.createdAt;
    if (exp != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(exp);
      String d24 = DateFormat('MM/dd/yyyy').format(dt);
      return Text("$d24");
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getRewardDate(context, widget.rewardHistory),
                SizedBox(
                  width: 80,
                  child: (widget.rewardHistory!.points! > 0)
                      ? Text("Points: +" +
                          widget.rewardHistory!.points!.toString())
                      : Text("Points: " +
                          widget.rewardHistory!.points!.toString()),
                )
              ],
            ),
          ]),
        ));
  }
}
