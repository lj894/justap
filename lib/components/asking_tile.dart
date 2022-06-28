import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/offer.dart';
import 'package:justap/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:justap/widgets/alert_dialog.dart';

class AskingTile extends StatefulWidget {
  final Offer? asking;

  const AskingTile({this.asking});

  @override
  _AskingTile createState() => _AskingTile();
}

class _AskingTile extends State<AskingTile> {
  @override
  void initState() {
    super.initState();
  }

  getAskingTime(context, time) {
    var millis = time; //widget.asking!.createdAt;
    if (millis != null) {
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      var d24 = DateFormat('MM/dd/yyyy HH:mm').format(dt);
      return Text("Created: $d24");
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getAskingTime(context, widget.asking?.createdAt),
                    Text("Status: ${widget.asking?.status}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Offer: ${widget.asking?.offerCredit} ${widget.asking?.offerStore} pts",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Text(
                            "Ask: ${widget.asking?.askingCredit} ${widget.asking?.askingStore} pts",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 50,
                        height: 20,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              textStyle: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          child: const Text("Edit"),
                          onPressed: () async {},
                        )),
                    const SizedBox(width: 30),
                    SizedBox(
                        width: 50,
                        height: 20,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              textStyle: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          child: const Text("Cancel"),
                          onPressed: () async {},
                        ))
                  ],
                )
              ],
            )));
  }
}
