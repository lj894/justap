import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/components/bottom_nav.dart';
import 'package:justap/controllers/user.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<WalletScreen> createState() => _WalletScreen();
}

class _WalletScreen extends State<WalletScreen> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse("http://justap.us"))) {
                await launchUrl(Uri.parse("http://justap.us"));
              }
            },
            child: const Image(
              image: AssetImage("assets/images/site_logo.png"),
              width: 80.0,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("My Wallet",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() {
                if (userController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userController.user().code != null) {
                  return QrImage(
                    data:
                        "https://app.justap.us/user/${userController.user().code}",
                    version: QrVersions.auto,
                    size: 320,
                    gapless: true,
                    padding: const EdgeInsets.all(16.0),
                    embeddedImage: AssetImage('assets/images/Icon_QR.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(50, 50),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}
