import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class RewardSlides extends StatefulWidget {
  const RewardSlides({
    Key? key,
    this.userToken,
  }) : super(key: key);

  final String? userToken;

  @override
  State<RewardSlides> createState() => _RewardSlides();
}

class _RewardSlides extends State<RewardSlides> {
  //final RewardController rewardController = Get.put(RewardController());

  final List<String> imageList = [
    "https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=496,h=624,fit=scale-down/mnlyEBexnEtW0B85/buyimg1-YlekzQLoy6TgE9Gw.png",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      //rewardController.fetchReward();
    });

    return GFCarousel(
      items: imageList.map(
        (url) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
            ),
          );
        },
      ).toList(),
      height: 180,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      hasPagination: true,
      activeIndicator: Colors.white,
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
