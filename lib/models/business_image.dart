import 'dart:convert';

List<BusinessImage> businessImageFromJson(String str) =>
    List<BusinessImage>.from(
        json.decode(str).map((x) => BusinessImage.fromJson(x)));

String businessImageToJson(List<BusinessImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusinessImage {
  BusinessImage({
    this.url,
    this.code,
    this.timeStamp,
  });

  String? url;
  String? code;
  int? timeStamp;

  factory BusinessImage.fromJson(Map<String, dynamic> json) => BusinessImage(
      url: json["url"],
      code: json["code"],
      timeStamp: DateTime.now().millisecondsSinceEpoch);

  Map<String, dynamic> toJson() =>
      {"url": url, "code": code, "timeStamp": timeStamp};
}
