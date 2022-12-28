import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDialog extends StatefulWidget {
  String? qrString;

  QRCodeDialog({this.qrString});

  @override
  _QRCodeDialog createState() => _QRCodeDialog();
}

class _QRCodeDialog extends State<QRCodeDialog> {
  void initState() {
    super.initState();
  }

  BuildContext? dialogContext;

  String? notes = "";
  final TabHistoryController historyController =
      Get.put(TabHistoryController());

  @override
  Widget build(BuildContext context) {
    dialogContext = context;
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text("QR Code", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        body: Container(
            margin: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // QrImage(
                      //   data: "https://app.justap.us/user/${widget.qrString}",
                      //   version: QrVersions.auto,
                      //   size: 200.0,
                      // ),
                      QrImage(
                        data: "https://app.justap.us/user/${widget.qrString}",
                        version: QrVersions.auto,
                        size: 320,
                        gapless: true,
                        padding: const EdgeInsets.all(16.0),
                        embeddedImage: AssetImage('assets/images/Icon_QR.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(50, 50),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Flexible(
                  //       flex: 1,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           ElevatedButton(
                  //             style: ElevatedButton.styleFrom(
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(18.0),
                  //                     side:
                  //                         const BorderSide(color: Colors.grey)),
                  //                 primary: Colors.black,
                  //                 padding: const EdgeInsets.symmetric(
                  //                     horizontal: 15, vertical: 10),
                  //                 textStyle: const TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold)),
                  //             child: const Text("SAVE TO WALLET"),
                  //             onPressed: () async {},
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )));
  }
}
