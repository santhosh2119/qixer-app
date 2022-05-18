import 'package:flutter/cupertino.dart';

class BookService with ChangeNotifier {
  int? serviceId;
  String? serviceTitle;
  String? serviceImage;

  setData(id, title, image) {
    serviceId = id;
    serviceTitle = title;
    serviceImage = image;
    notifyListeners();
  }
}
