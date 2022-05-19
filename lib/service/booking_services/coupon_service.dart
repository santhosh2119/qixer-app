import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class CouponService with ChangeNotifier {
  var coupon;

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> getCouponDiscount(
      couponCode, totalAmount, sellerId, BuildContext context) async {
    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();
      var data = jsonEncode({
        'coupon_code': couponCode,
        'total_amount': totalAmount,
        'seller_id': sellerId
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(
          Uri.parse('$baseApi/service-list/coupon-apply'),
          body: data,
          headers: header);

      if (response.statusCode == 201) {
        coupon = jsonDecode(response.body)['coupon_amount'];
        print('coupon amount is $coupon');

        // Provider.of<BookConfirmationService>(context, listen: false)
        //     .caculateTotalAfterCouponApplied(coupon);
        notifyListeners();
        return true;
      } else {
        //something went wrong
        return false;
      }
    } else {
      //internet off
      return false;
    }
  }
}
