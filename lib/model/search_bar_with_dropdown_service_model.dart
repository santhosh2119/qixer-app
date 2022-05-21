// To parse this JSON data, do
//
//     final searchBarWithDropdownServiceModel = searchBarWithDropdownServiceModelFromJson(jsonString);

import 'dart:convert';

SearchBarWithDropdownServiceModel searchBarWithDropdownServiceModelFromJson(
        String str) =>
    SearchBarWithDropdownServiceModel.fromJson(json.decode(str));

String searchBarWithDropdownServiceModelToJson(
        SearchBarWithDropdownServiceModel data) =>
    json.encode(data.toJson());

class SearchBarWithDropdownServiceModel {
  SearchBarWithDropdownServiceModel({
    required this.services,
    required this.serviceImage,
  });

  List<Service> services;
  List<dynamic> serviceImage;

  factory SearchBarWithDropdownServiceModel.fromJson(
          Map<String, dynamic> json) =>
      SearchBarWithDropdownServiceModel(
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        serviceImage: List<dynamic>.from(json["service_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "service_image": List<dynamic>.from(serviceImage.map((x) => x)),
      };
}

class ServiceImageClass {
  ServiceImageClass({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory ServiceImageClass.fromJson(Map<String, dynamic> json) =>
      ServiceImageClass(
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

class Service {
  Service({
    this.title,
    this.slug,
    this.image,
    this.price,
  });

  String? title;
  String? slug;
  String? image;
  int? price;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        title: json["title"],
        slug: json["slug"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "image": image,
        "price": price,
      };
}
