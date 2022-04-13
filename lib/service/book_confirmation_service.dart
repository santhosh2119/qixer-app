import 'package:flutter/cupertino.dart';

class BookConfirmationService with ChangeNotifier {
  bool isPanelOpened = false;

  setPanelOpenedTrue() {
    isPanelOpened = true;
    notifyListeners();
  }

  setPanelOpenedFalse() {
    isPanelOpened = false;
    notifyListeners();
  }
}
