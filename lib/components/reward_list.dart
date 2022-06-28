import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/reward.dart';
import 'package:justap/screens/edit_log_dialog.dart';
import 'package:justap/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RewardTile extends StatefulWidget {
  final Reward? reward;

  const RewardTile({this.reward});

  @override
  _RewardTile createState() => _RewardTile();
}

class _RewardTile extends State<RewardTile> {
  get $d24 => null;

  @override
  void initState() {
    super.initState();
  }

  getRewardProfile(context, reward) {
    String? type = widget.reward!.type;
    if (type == "TEA") {
      return Image.asset(
        "assets/images/Tea.png",
        width: 50,
        height: 50,
        fit: BoxFit.scaleDown,
      );
    } else if (type == "FOOD") {
      return Image.asset(
        "assets/images/Noddle.png",
        width: 50,
        height: 50,
        fit: BoxFit.scaleDown,
      );
    } else {
      return Image.asset(
        "assets/images/Tea.png",
        width: 50,
        height: 50,
        fit: BoxFit.scaleDown,
      );
    }
  }

  getRewardProgress(context, reward) {
    int credit = widget.reward!.credit != null ? widget.reward!.credit! : 0;
    int? fullCredit = widget.reward!.fullCredit;
    if (fullCredit != null) {
      return CircularPercentIndicator(
        radius: 30.0,
        lineWidth: 5.0,
        percent: credit / fullCredit,
        center: Text("${credit * 100 / fullCredit}%"),
        progressColor: Colors.black,
      );
    } else {
      return const Text("");
    }
  }

  getRewardCredit(context, reward) {
    int credit = widget.reward!.credit != null ? widget.reward!.credit! : 0;
    int? fullCredit = widget.reward!.fullCredit;
    if (fullCredit != null) {
      return Text("$credit/$fullCredit");
    } else {
      return const Text("");
    }
  }

  getRewardDate(context, reward) {
    var exp = widget.reward!.expiryAt;
    if (exp != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(exp);
      String d24 = DateFormat('MM/dd/yyyy').format(dt);
      return Text("Exp: $d24");
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) =>
                          //         EditRewardDialog(reward: widget.reward),
                          //     fullscreenDialog: true,
                          //   ),
                          // );
                        },
                        child: Row(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.contain,
                              child: getRewardProfile(context, widget.reward),
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                                width: 80,
                                child: Text(
                                  widget.reward!.store == null
                                      ? ""
                                      : widget.reward!.store!,
                                  overflow: TextOverflow.clip,
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 60,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute<void>(
                                  //     builder: (BuildContext context) =>
                                  //         EditRewardDialog(
                                  //             reward: widget.reward),
                                  //     fullscreenDialog: true,
                                  //   ),
                                  // );
                                },
                                child:
                                    getRewardProgress(context, widget.reward),
                              )),
                          const SizedBox(width: 10),
                          SizedBox(
                              width: 40,
                              child: getRewardCredit(context, widget.reward)),
                          const SizedBox(width: 10),
                          getRewardDate(context, widget.reward)
                        ],
                      ),
                    ]),
              ],
            )));
  }
}
