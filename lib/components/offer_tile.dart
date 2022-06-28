import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justap/models/offer.dart';
import 'package:justap/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:justap/widgets/alert_dialog.dart';

class OfferTile extends StatefulWidget {
  final Offer? offer;

  const OfferTile({this.offer});

  @override
  _OfferTile createState() => _OfferTile();
}

class _OfferTile extends State<OfferTile> {
  @override
  void initState() {
    super.initState();
  }

  getOfferProfile(context, offer) {
    String? link;
    String? user;
    //var link = widget.history!.profileLink;
    user = widget.offer!.user;
    if (link != null) {
      return Column(
        children: [
          Image.network(
            link,
            width: 10,
            height: 10,
            fit: BoxFit.cover,
          ),
          Text(user ?? "No name")
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(
            "assets/images/avatar_placeholder.png",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          Text(user ?? "No name")
        ],
      );
    }
  }

  getOfferLog(context, history) {
    var millis = widget.offer!.createdAt;
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
                  children: [
                    getOfferProfile(context, widget.offer),
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Offer: ${widget.offer?.offerCredit} ${widget.offer?.offerStore} pts",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Text(
                            "Ask: ${widget.offer?.askingCredit} ${widget.offer?.askingStore} pts",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    )
                  ],
                ),
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
                          child: const Text("Buy"),
                          onPressed: () async {},
                        ))
                  ],
                )
              ],
            )));
  }
}
