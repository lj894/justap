import 'dart:convert';

List<Media> mediaFromJson(String str) =>
    List<Media>.from(json.decode(str).map((x) => Media.fromJson(x)));

String mediaToJson(List<Media> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Media {
  Media({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.priceSign,
    required this.currency,
    required this.imageLink,
    required this.productLink,
    required this.websiteLink,
    required this.description,
    required this.rating,
    required this.category,
    required this.productType,
    required this.productApiUrl,
    required this.apiFeaturedImage,
  });

  dynamic id;
  String brand;
  String name;
  String price;
  dynamic priceSign;
  dynamic currency;
  String imageLink;
  String productLink;
  String websiteLink;
  String description;
  dynamic rating;
  dynamic category;
  String productType;
  String productApiUrl;
  String apiFeaturedImage;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"] == null ? null : json["id"],
        brand: json["brand"] == null ? null : json["brand"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        priceSign: json["price_sign"],
        currency: json["currency"],
        imageLink: json["image_link"] == null ? null : json["image_link"],
        productLink: json["product_link"] == null ? null : json["product_link"],
        websiteLink: json["website_link"] == null ? null : json["website_link"],
        description: json["description"] == null ? null : json["description"],
        rating: json["rating"] == null ? null : json["rating"],
        category: json["category"],
        productType: json["product_type"] == null ? null : json["product_type"],
        productApiUrl:
            json["product_api_url"] == null ? null : json["product_api_url"],
        apiFeaturedImage: json["api_featured_image"] == null
            ? null
            : json["api_featured_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "brand": brand == null ? null : brand,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "price_sign": priceSign,
        "currency": currency,
        "image_link": imageLink == null ? null : imageLink,
        "product_link": productLink == null ? null : productLink,
        "website_link": websiteLink == null ? null : websiteLink,
        "description": description == null ? null : description,
        "rating": rating == null ? null : rating,
        "category": category,
        "product_type": productType == null ? null : productType,
        "product_api_url": productApiUrl == null ? null : productApiUrl,
        "api_featured_image":
            apiFeaturedImage == null ? null : apiFeaturedImage,
      };
}
