import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/history.dart';
import 'package:justap/screens/edit_log_dialog.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/controllers/history.dart';
import 'package:get/get.dart';
import 'package:justap/widgets/alert_dialog.dart';

class TabHistoryTile extends StatefulWidget {
  final TabHistory? history;

  const TabHistoryTile({this.history});

  @override
  _TabHistoryTile createState() => _TabHistoryTile();
}

class _TabHistoryTile extends State<TabHistoryTile> {
  @override
  void initState() {
    super.initState();
  }

  getTabHistoryProfile(context, history) {
    String? link = widget.history!.profileUrl;
    if (link != null) {
      return Image.network(
        link,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/avatar_placeholder.png",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }

  getTabHistoryLog(context, history) {
    var millis = widget.history!.createdAt;
    if (millis != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var d24 = DateFormat('MM/dd/yyyy HH:mm').format(dt);
      return Text(d24);
    } else {
      return Container();
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
                          //         EditTabHistoryDialog(history: widget.history),
                          //     fullscreenDialog: true,
                          //   ),
                          // );
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              width: 50,
                              child:
                                  getTabHistoryProfile(context, widget.history),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              widget.history!.nickName == null
                                  ? "Anonymous"
                                  : widget.history!.nickName!,
                              style: const TextStyle(
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.w800),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      EditTabHistoryDialog(
                                          history: widget.history),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: const Icon(Icons.edit_note,
                                color: Colors.black),
                          ),
                          const SizedBox(width: 15),
                          getTabHistoryLog(context, widget.history)
                          // GestureDetector(
                          //   onTap: () {
                          //     showConfirmDialog(
                          //         context,
                          //         "Delete Log",
                          //         "Are you sure you wish to delete this log?",
                          //         () => () async {
                          //               // await RemoteServices.resetProfileCode();
                          //               // userController.fetchUser();
                          //               // setState(() {});
                          //             });
                          //   },
                          //   child: const Icon(Icons.delete, color: Colors.black),
                          // ),
                        ],
                      ),
                    ]),
                Row(children: [
                  const SizedBox(width: 65),
                  Text(
                    widget.history!.notes == null ? "" : widget.history!.notes!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'avenir', fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                  )
                ]),
              ],
            )));
  }
}
