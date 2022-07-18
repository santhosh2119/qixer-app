// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';

import '../payment_gateway_list_service.dart';

class MercadoPagoService {
  String? token;
  // String publicKey = "TEST-0a3cc78a-57bf-4556-9dbe-2afa06347769";
  // String accessToken =
  //     "TEST-4644184554273630-070813-7d817e2ca1576e75884001d0755f8a7a-786499991";

  mercadoPay(BuildContext context) async {
    String publicKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .publicKey ??
            '';

    var result = await getToken(context);

    if (result == true) {
      print('mercado token is $token');
      var res = await MercadoPagoMobileCheckout.startCheckout(
        publicKey,
        token ?? '',
      );
      if (res.result == 'done') {
        Provider.of<PlaceOrderService>(context, listen: false)
            .makePaymentSuccess(context);
      } else {
        print('payment failed');
        Provider.of<PlaceOrderService>(context, listen: false)
            .setLoadingFalse();
      }
    } else {
      //token getting failed
    }
  }

  Future<bool> getToken(BuildContext context) async {
    String accessToken =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .secretKey ??
            '';

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var data = jsonEncode({
      "items": [
        {
          "title": "Dummy Item",
          "description": "Multicolor Item",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": 10.0
        }
      ],
      "payer": {"email": "payer@email.com"}
    });

    var response = await http.post(
        Uri.parse(
            'https://api.mercadopago.com/checkout/preferences?access_token=$accessToken'),
        headers: header,
        body: data);

    if (response.statusCode == 201) {
      token = jsonDecode(response.body)['id'];

      print(response.body);
      return true;
    } else {
      print('token get failed');
      return false;
    }
  }
}
