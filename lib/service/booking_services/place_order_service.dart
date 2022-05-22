import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/coupon_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderService with ChangeNotifier {
  placeOrder(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List includesList = [];
    List extrasList = [];

    List includes = Provider.of<PersonalizationService>(context, listen: false)
        .includedList;
    List extras =
        Provider.of<PersonalizationService>(context, listen: false).extrasList;

    var serviceId = Provider.of<BookService>(context, listen: false).serviceId;
    var sellerId = Provider.of<BookService>(context, listen: false).sellerId;
    var buyerId = prefs.getInt('userId');
    var name = Provider.of<BookService>(context, listen: false).name;
    var email = Provider.of<BookService>(context, listen: false).email;
    var phone = Provider.of<BookService>(context, listen: false).phone;
    var post = Provider.of<BookService>(context, listen: false).postCode;
    var address = Provider.of<BookService>(context, listen: false).address;
    var city = Provider.of<CountryStatesService>(context, listen: false)
        .selectedStateId;
    var area = Provider.of<CountryStatesService>(context, listen: false)
        .selectedAreaId;
    var country = Provider.of<CountryStatesService>(context, listen: false)
        .selectedCountryId;
    var selectedDate =
        Provider.of<BookService>(context, listen: false).selectedDateAndMonth;
    var schedule =
        Provider.of<BookService>(context, listen: false).selectedTime;
    var coupon =
        Provider.of<CouponService>(context, listen: false).appliedCoupon;
    var selectedPaymentGateway =
        Provider.of<BookService>(context, listen: false).selectedPayment;

    //includes list
    for (int i = 0; i < includes.length; i++) {
      includesList.add({
        'order_id': "1",
        "title": includes[i]['title'],
        "price": includes[i]['price'],
        "quantity": includes[i]['qty']
      });
    }

    //extras list
    for (int i = 0; i < extras.length; i++) {
      extrasList.add({
        'order_id': "1",
        "additional_service_title": extras[i]['title'],
        "additional_service_price": extras[i]['price'],
        "quantity": includes[i]['qty']
      });
    }

    var data = jsonEncode({
      'service_id': serviceId,
      'seller_id': sellerId,
      'buyer_id': buyerId,
      'name': name,
      'email': email,
      'phone': phone, //amount he paid in bkash ucash etc
      'post_code': post,
      'address': address,
      'choose_service_city': city,
      'choose_service_area': area,
      'choose_service_country': country,
      'date': selectedDate,
      'schedule': schedule,
      'include_services': includesList,
      'additional_services': extrasList,
      'coupon_code': coupon,
      'selected_payment_gateway': selectedPaymentGateway,
    });

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var response = await http.post(Uri.parse('$baseApi/service/order'),
        body: data, headers: header);

    if (response.statusCode == 201) {
      OthersHelper().showToast('Order Placed', Colors.black);
    } else {
      print(response.body);
    }

    //
  }
}
