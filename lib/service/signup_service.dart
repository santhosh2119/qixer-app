import 'package:flutter/cupertino.dart';

class SignupService with ChangeNotifier {
  int selectedPage = 0;

  var pagecontroller;

  setPageController(p) {
    pagecontroller = p;
    Future.delayed(const Duration(milliseconds: 400), () {
      notifyListeners();
    });
  }

  setSelectedPage(int i) {
    selectedPage = i;
    notifyListeners();
  }
}
