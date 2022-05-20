// To parse this JSON data, do
//
//     final categorybyServiceModel = categorybyServiceModelFromJson(jsonString);

import 'dart:convert';

ServicebyCategoryModel categorybyServiceModelFromJson(String str) =>
    ServicebyCategoryModel.fromJson(json.decode(str));

String categorybyServiceModelToJson(ServicebyCategoryModel data) =>
    json.encode(data.toJson());

class ServicebyCategoryModel {
  ServicebyCategoryModel({
    required this.allServices,
    required this.serviceImage,
  });

  List<AllService> allServices;
  List<ServiceImage> serviceImage;

  factory ServicebyCategoryModel.fromJson(Map<String, dynamic> json) =>
      ServicebyCategoryModel(
        allServices: List<AllService>.from(
            json["all_services"].map((x) => AllService.fromJson(x))),
        serviceImage: List<ServiceImage>.from(
            json["service_image"].map((x) => ServiceImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_services": List<dynamic>.from(allServices.map((x) => x.toJson())),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x.toJson())),
      };
}

class AllService {
  AllService({
    this.id,
    this.sellerId,
    this.title,
    this.price,
    this.image,
    this.isServiceOnline,
    this.serviceCityId,
    required this.sellerForMobile,
    required this.reviewsForMobile,
    required this.serviceCity,
  });

  int? id;
  int? sellerId;
  String? title;
  double? price;
  String? image;
  int? isServiceOnline;
  int? serviceCityId;
  SellerForMobile sellerForMobile;
  List<ReviewsForMobile> reviewsForMobile;
  ServiceCity serviceCity;

  factory AllService.fromJson(Map<String, dynamic> json) => AllService(
        id: json["id"],
        sellerId: json["seller_id"],
        title: json["title"],
        price: json["price"].toDouble(),
        image: json["image"],
        isServiceOnline: json["is_service_online"],
        serviceCityId: json["service_city_id"],
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
        serviceCity: ServiceCity.fromJson(json["service_city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "title": title,
        "price": price,
        "image": image,
        "is_service_online": isServiceOnline,
        "service_city_id": serviceCityId,
        "seller_for_mobile": sellerForMobile.toJson(),
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
        "service_city": serviceCity.toJson(),
      };
}

class ReviewsForMobile {
  ReviewsForMobile({
    this.id,
    this.serviceId,
    this.rating,
    this.message,
    this.buyerId,
  });

  int? id;
  int? serviceId;
  int? rating;
  String? message;
  int? buyerId;

  factory ReviewsForMobile.fromJson(Map<String, dynamic> json) =>
      ReviewsForMobile(
        id: json["id"],
        serviceId: json["service_id"],
        rating: json["rating"],
        message: json["message"],
        buyerId: json["buyer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyer_id": buyerId,
      };
}

class SellerForMobile {
  SellerForMobile({
    this.id,
    this.name,
    this.image,
    this.countryId,
  });

  int? id;
  String? name;
  String? image;
  int? countryId;

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
      };
}

class ServiceCity {
  ServiceCity({
    this.id,
    this.serviceCity,
    this.countryId,
    this.status,
    required this.countryy,
  });

  int? id;
  String? serviceCity;
  int? countryId;
  int? status;

  Countryy countryy;

  factory ServiceCity.fromJson(Map<String, dynamic> json) => ServiceCity(
        id: json["id"],
        serviceCity: json["service_city"],
        countryId: json["country_id"],
        status: json["status"],
        countryy: Countryy.fromJson(json["countryy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_city": serviceCity,
        "country_id": countryId,
        "status": status,
        "countryy": countryy.toJson(),
      };
}

class Countryy {
  Countryy({
    this.id,
    this.country,
    this.status,
  });

  int? id;
  String? country;
  int? status;

  factory Countryy.fromJson(Map<String, dynamic> json) => Countryy(
        id: json["id"],
        country: json["country"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "status": status,
      };
}

class ServiceImage {
  ServiceImage({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
        imageId: json["image_id"],
        path: json["path"],
        imgUrl: json["img_url"],
        imgAlt: json["img_alt"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "path": path,
        "img_url": imgUrl,
        "img_alt": imgAlt,
      };
}
