import 'package:flutter/cupertino.dart';

class BookService with ChangeNotifier {
  int? serviceId;
  String? serviceTitle;
  String? serviceImage;
  int totalPrice = 0;
  int? sellerId;

  setData(id, title, image, newPrice, sellerNewId) {
    serviceId = id;
    serviceTitle = title;
    serviceImage = image;
    totalPrice = newPrice;
    sellerId = sellerNewId;
    notifyListeners();
  }

  setTotalPrice(newPrice) {
    totalPrice = newPrice;
    notifyListeners();
  }

  defaultTotalPrice() {
    totalPrice = 0;
    notifyListeners();
  }
}
