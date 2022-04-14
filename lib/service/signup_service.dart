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

  // nextPage(){
  //   pagecontroller.animateToPage(selectedPage + 1,
  //                   duration: const Duration(milliseconds: 300),
  //                   curve: Curves.ease);
  // }

  prevPage(int i) {
    selectedPage = i;
    notifyListeners();
  }
}
