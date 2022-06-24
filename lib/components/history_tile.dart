import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/history.dart';
import 'package:justap/screens/edit_log_dialog.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/controllers/history.dart';
import 'package:get/get.dart';
import 'package:justap/widgets/alert_dialog.dart';

class HistoryTile extends StatefulWidget {
  final History? history;

  const HistoryTile({this.history});

  @override
  _HistoryTile createState() => _HistoryTile();
}

class _HistoryTile extends State<HistoryTile> {
  @override
  void initState() {
    super.initState();
  }

  getHistoryLog(context, history) {
    var millis = widget.history!.createdAt;
    if (millis != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var d24 = DateFormat('MM/dd/yyyy HH:mm').format(dt);
      return Container(
        // Image tapped
        child: Container(child: Text(d24)),
      );
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
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) =>
                      //         EditHistoryDialog(history: widget.history),
                      //     fullscreenDialog: true,
                      //   ),
                      // );
                    },
                    child: Row(
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: getHistoryLog(context, widget.history),
                        ),
                        SizedBox(width: 15),
                        Text(
                          widget.history!.notes == null
                              ? ""
                              : widget.history!.notes!,
                          maxLines: 1,
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
                                  EditHistoryDialog(history: widget.history),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: const Icon(Icons.edit, color: Colors.black),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          showConfirmDialog(
                              context,
                              "Delete Log",
                              "Are you sure you wish to delete this log?",
                              () => () async {
                                    // await RemoteServices.resetProfileCode();
                                    // userController.fetchUser();
                                    // setState(() {});
                                  });
                        },
                        child: const Icon(Icons.delete, color: Colors.black),
                      ),
                    ],
                  )
                ])));
  }
}
