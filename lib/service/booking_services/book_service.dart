import 'package:flutter/cupertino.dart';

class BookService with ChangeNotifier {
  int? serviceId;
  String? serviceTitle;
  String? serviceImage;
  int totalPrice = 0;

  setData(id, title, image, newPrice) {
    serviceId = id;
    serviceTitle = title;
    serviceImage = image;
    totalPrice = newPrice;
    notifyListeners();
  }

  setTotalPrice(newPrice) {
    totalPrice = newPrice;
    notifyListeners();
  }
}
