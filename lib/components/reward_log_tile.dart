import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/reward_log.dart';
import 'package:justap/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:justap/widgets/alert_dialog.dart';

class RewardLogTile extends StatefulWidget {
  final RewardLog? rewardLog;

  const RewardLogTile({this.rewardLog});

  @override
  _RewardLogTile createState() => _RewardLogTile();
}

class _RewardLogTile extends State<RewardLogTile> {
  @override
  void initState() {
    super.initState();
  }

  getLogTime(context, time) {
    var millis = time; //widget.asking!.createdAt;
    if (millis != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var d24 = DateFormat('MM/dd/yyyy HH:mm').format(dt);
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  getLogTime(context, widget.rewardLog?.createdAt),
                ],
              ),
              const SizedBox(height: 5),
              Row(children: [
                Flexible(
                    child: Text("${widget.rewardLog?.message}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ))),
              ])
            ],
          ),
        ));
  }
}
