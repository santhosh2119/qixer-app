import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_steps_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/coupon_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/booking/payment_success_page.dart';
import 'package:qixer/view/home/home.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  placeOrder(BuildContext context, String? imagePath) async {
    setLoadingTrue();
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

    var formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';

    if (imagePath != null) {
      //if manual transfer selected then image upload is mandatory
      formData = FormData.fromMap({
        'service_id': serviceId.toString(),
        'seller_id': sellerId.toString(),
        'buyer_id': buyerId.toString(),
        'name': name,
        'email': email,
        'phone': phone, //amount he paid in bkash ucash etc
        'post_code': post,
        'address': address,
        'choose_service_city': city.toString(),
        'choose_service_area': area.toString(),
        'choose_service_country': country.toString(),
        'date': selectedDate.toString(),
        'schedule': schedule.toString(),
        'include_services': jsonEncode({"include_services": includesList}),
        'additional_services': jsonEncode({"additional_services": extrasList}),
        'coupon_code': coupon.toString(),
        'selected_payment_gateway': selectedPaymentGateway.toString(),
        'manual_payment_image': await MultipartFile.fromFile(imagePath,
            filename: 'bankTransfer$name$address$imagePath.jpg'),
      });
    } else {
      //other payment method selected
      formData = FormData.fromMap({
        'service_id': serviceId.toString(),
        'seller_id': sellerId.toString(),
        'buyer_id': buyerId.toString(),
        'name': name,
        'email': email,
        'phone': phone, //amount he paid in bkash ucash etc
        'post_code': post,
        'address': address,
        'choose_service_city': city.toString(),
        'choose_service_area': area.toString(),
        'choose_service_country': country.toString(),
        'date': selectedDate.toString(),
        'schedule': schedule.toString(),
        'include_services': jsonEncode({"include_services": includesList}),
        'additional_services': jsonEncode({"additional_services": extrasList}),
        'coupon_code': coupon.toString(),
        'selected_payment_gateway': selectedPaymentGateway.toString(),
      });
    }

    var response = await dio.post(
      '$baseApi/service/order',
      data: formData,
    );

    setLoadingFalse();
    if (response.statusCode == 201) {
      OthersHelper().showToast('Order placed successfully', Colors.black);
      print(response.data);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LandingPage()),
          (Route<dynamic> route) => false);

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PaymentSuccessPage(),
        ),
      );

      //reset steps
      Provider.of<BookStepsService>(context, listen: false).setStepsToDefault();
    } else {
      print(response.data);
      OthersHelper().showToast('Something went wrong', Colors.black);
    }

    //
  }
}