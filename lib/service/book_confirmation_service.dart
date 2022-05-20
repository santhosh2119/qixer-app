import 'package:flutter/cupertino.dart';

class BookConfirmationService with ChangeNotifier {
  bool isPanelOpened = false;

  double totalPriceAfterAllcalculation = 0;

  setPanelOpenedTrue() {
    isPanelOpened = true;
    notifyListeners();
  }

  setPanelOpenedFalse() {
    isPanelOpened = false;
    notifyListeners();
  }

  includedTotalPrice(List includedList) {
    var total = 0;
    for (int i = 0; i < includedList.length; i++) {
      total =
          total + (includedList[i]['price'] * includedList[i]['qty']) as int;
    }
    return total;
  }

  extrasTotalPrice(List extrasList) {
    var total = 0;
    for (int i = 0; i < extrasList.length; i++) {
      if (extrasList[i]['selected'] == true) {
        total = total + (extrasList[i]['price'] * extrasList[i]['qty']) as int;
      }
    }
    return total;
  }

  calculateSubtotal(List includedList, List extrasList) {
    var includedTotal = 0;
    var extraTotal = 0;
    includedTotal = includedTotalPrice(includedList);
    extraTotal = extrasTotalPrice(extrasList);
    return includedTotal + extraTotal;
  }

  calculateTax(
    taxPercent,
    List includedList,
    List extrasList,
  ) {
    var subTotal = calculateSubtotal(includedList, extrasList);
    var tax = (subTotal * taxPercent) / 100;

    return tax;
  }

  calculateTotal(taxPercent, List includedList, List extrasList) {
    var subTotal = calculateSubtotal(includedList, extrasList);
    var tax = calculateTax(taxPercent, includedList, extrasList);
    totalPriceAfterAllcalculation = subTotal + tax;
    Future.delayed(Duration(microseconds: 500), () {
      notifyListeners();
    });
  }

  caculateTotalAfterCouponApplied(couponDiscount) {
    totalPriceAfterAllcalculation =
        totalPriceAfterAllcalculation - couponDiscount;
    notifyListeners();
  }
}
