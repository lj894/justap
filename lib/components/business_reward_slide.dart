import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:justap/models/business_image.dart';

class BusinessRewardSlide extends StatefulWidget {
  final List<BusinessImage> businessImageList;

  const BusinessRewardSlide({required this.businessImageList});

  @override
  State<BusinessRewardSlide> createState() => _BusinessRewardSlide();
}

class _BusinessRewardSlide extends State<BusinessRewardSlide> {
  final List<String> defaultAdList = [
    "assets/ads/AD_1.png",
    "assets/ads/AD_2.png",
    "assets/ads/AD_3.png",
    "assets/ads/AD_4.png",
    "assets/ads/AD_5.png",
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders;
    if (widget.businessImageList.length > 0) {
      imageSliders = widget.businessImageList
          .map((item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                              item.url! + "?" + item.timeStamp.toString(),
                              fit: BoxFit.cover,
                              width: 1000),
                        ],
                      )),
                ),
              ))
          .toList();
    } else {
      imageSliders = defaultAdList
          .map((item) => Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                        ],
                      )),
                ),
              ))
          .toList();
    }

    return Container(
      height: (kIsWeb) ? 200 : null,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          //height: 200,
          aspectRatio: 2.0,
          enlargeCenterPage: false,
        ),
        items: imageSliders,
      ),
    );
  }
}
