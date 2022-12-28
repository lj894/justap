import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/reward.dart';
import 'package:justap/screens/reward_detail_dialog.dart';
import 'package:justap/services/remote_services.dart';
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
    String? url = widget.reward!.businessProfileUrl;
    if (url != null) {
      return Image.network(
        url,
        //"assets/images/Tea.png",
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
    int credit =
        widget.reward!.totalPoints != null ? widget.reward!.totalPoints! : 0;
    int redeemPoints = 10;
    if (widget.reward!.redeemPoints != null) {
      redeemPoints = widget.reward!.redeemPoints!;
    }
    double pct = 0;
    if (credit * 100 / redeemPoints >= 100) {
      pct = 100;
    } else {
      pct = credit * 100 / redeemPoints;
    }

    return CircularPercentIndicator(
      radius: 25.0,
      lineWidth: 5.0,
      percent: credit / redeemPoints > 1.0 ? 1.0 : credit / redeemPoints,
      center: Text(
        "${pct.toStringAsFixed(1)}%",
        style: TextStyle(fontSize: 10),
      ),
      progressColor: Colors.black,
    );
  }

  getRewardCredit(context, reward) {
    int credit =
        widget.reward!.totalPoints != null ? widget.reward!.totalPoints! : 0;
    int? fullCredit = 10;
    if (widget.reward!.redeemPoints != null) {
      fullCredit = widget.reward!.redeemPoints;
    }
    return Text(
      "$credit/$fullCredit",
      style: TextStyle(fontSize: 12),
    );
  }

  getRewardDate(context, reward) {
    var exp = widget.reward!.businessRewardExpiredAt;
    if (exp != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(exp);
      String d24 = DateFormat('MM/dd/yyyy').format(dt);
      return Text(
        "Exp: $d24",
        style: TextStyle(fontSize: 10),
      );
    } else {
      return const Text("");
    }
  }

  getRewardStatus(context, reward) {
    var isExpired = widget.reward!.isExpired;
    var countDownDays = widget.reward!.countDownDays;
    if (isExpired == true) {
      return Text("Expired", style: TextStyle(color: Colors.red, fontSize: 10));
    } else if (countDownDays! < 31) {
      return Text(
          "Expires in " + widget.reward!.countDownDays.toString() + " days",
          style: TextStyle(color: Colors.red, fontSize: 10));
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  RewardDetailDialog(reward: widget.reward),
              fullscreenDialog: true,
            ),
          );
        },
        child: Card(
            color: widget.reward?.isExpired == true
                ? Color.fromRGBO(225, 225, 225, .5)
                : Colors.white,
            elevation: 1,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: getRewardProfile(context, widget.reward),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            widget.reward!.businessName == null
                                                ? ""
                                                : widget.reward!.businessName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          )),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            widget.reward!.businessRewardName ==
                                                    null
                                                ? ""
                                                : widget.reward!
                                                    .businessRewardName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12),
                                          )),
                                      const SizedBox(height: 10),
                                      getRewardDate(context, widget.reward),
                                    ],
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 55,
                                      child: getRewardCredit(
                                          context, widget.reward)),
                                  const SizedBox(width: 15),
                                  SizedBox(
                                    width: 40,
                                    child: getRewardProgress(
                                        context, widget.reward),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  getRewardStatus(context, widget.reward),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
