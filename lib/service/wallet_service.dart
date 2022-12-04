import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/wallet_history_model.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletService with ChangeNotifier {
  var walletHistory;
  var walletBalance = '\$0.0';

  bool isloading = false;
  bool hasWalletHistory = true;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  var amountToAdd;

  setAmount(v) {
    amountToAdd = v;
    notifyListeners();
  }

  Future<bool> depositeToWallet(BuildContext context) async {
    return true;
  }

  // Fetch subscription history
  fetchWalletHistory(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingStatus(true);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http.get(Uri.parse('$baseApi/user/wallet/history'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 200 && decodedData['history'].isNotEmpty) {
      final data = WalletHistoryModel.fromJson(jsonDecode(response.body));
      walletHistory = data.history;
      notifyListeners();
    } else {
      print('Error fetching wallet history' + response.body);

      hasWalletHistory = false;
      notifyListeners();
    }
  }

  // Fetch wallet balance
  Future<bool> fetchWalletBalance(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingStatus(true);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http.get(Uri.parse('$baseApi/user/wallet/balance'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      walletBalance = decodedData['balance'];
      notifyListeners();

      return true;
    } else {
      print('Error fetching wallet balance' + response.body);

      return false;
    }
  }

  //============>
  //=========>

  Future<bool> createDepositeRequest(BuildContext context,
      {bool manualPaymentSelected = false, imagePath}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var connection = await checkConnection();
    if (!connection) return false;
    //if connection is ok

    var selectedPayment =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .selectedMethodName ??
            'cash_on_delivery';

    FormData formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";

    if (manualPaymentSelected == true) {
      formData = FormData.fromMap({
        'amount': amountToAdd,
        'payment_gateway': selectedPayment,
        'manual_payment_image': await MultipartFile.fromFile(imagePath,
            filename: 'bankTransfer.jpg'),
      });
    } else {
      formData = FormData.fromMap({
        'amount': amountToAdd,
        'payment_gateway': selectedPayment,
      });
    }

    var response = await dio.post(
      '$baseApi/user/wallet/deposit',
      data: formData,
    );

    setLoadingStatus(false);

    if (response.statusCode == 200) {
      await fetchWalletBalance(context);

      Navigator.pop(context);
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              const OrderExtraAcceptSuccessPage(),
        ),
      );
      return true;
    } else {
      print('error depositing to wallet ${response.data}');

      Navigator.pop(context);
      Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

      OthersHelper().showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  //=====================>
  //================>

  Future<bool> validate(BuildContext context, isFromDepositeToWallet) async {
    if (isFromDepositeToWallet && amountToAdd == null) {
      OthersHelper().showToast('You must enter an amount', Colors.black);
      return false;
    }
    if (isFromDepositeToWallet && double.tryParse(amountToAdd) == null) {
      // user entered non integer value
      OthersHelper().showToast('Please enter a valid amount', Colors.black);
      return false;
    }
    return true;
  }
}
