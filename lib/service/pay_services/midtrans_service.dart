import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/view/payments/midtrans/midtrans_payment_webview.dart';

class MidtransService with ChangeNotifier {
  var tokenId;

  getCardToken(BuildContext context) async {
    var client_key = 'SB-Mid-client-iDuy-jKdZHkLjL_I';
    var card_number = '4811 1111 1111 1114';
    var card_exp_month = '02';
    var card_exp_year = '24';
    var card_cvv = '123';

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var response = await http.get(
        Uri.parse(
            'https://api.sandbox.midtrans.com/v2/token?client_key=$client_key&card_number=$card_number&card_exp_month=$card_exp_month&card_exp_year=$card_exp_year&card_cvv=$card_cvv'),
        headers: header);

    if (response.statusCode == 200) {
      tokenId = jsonDecode(response.body)['token_id'];
      print(tokenId);

      //charge the card
      chargeCard(tokenId, context);
    } else {
      print('token get failed');
    }
  }

  // charge card ===============>
  // //========
  chargeCard(tokenId, context) async {
    var orderId = DateTime.now().millisecondsSinceEpoch;
    var data = jsonEncode({
      "payment_type": "credit_card",
      "transaction_details": {"order_id": "$orderId", "gross_amount": 100000},
      "credit_card": {"token_id": "$tokenId", "authentication": true},
      "item_details": [
        {
          "id": "a1",
          "price": 50000,
          "quantity": 2,
          "name": "Apel",
          "brand": "Fuji Apple",
          "category": "Fruit",
          "merchant_name": "Fruit-store"
        }
      ],
      "customer_details": {
        "first_name": "BUDI",
        "last_name": "UTOMO",
        "email": "noreply@example.com",
        "phone": "+628123456",
        "billing_address": {
          "first_name": "BUDI",
          "last_name": "UTOMO",
          "email": "noreply@example.com",
          "phone": "081 2233 44-55",
          "address": "Sudirman",
          "city": "Jakarta",
          "postal_code": "12190",
          "country_code": "IDN"
        },
        "shipping_address": {
          "first_name": "BUDI",
          "last_name": "UTOMO",
          "email": "noreply@example.com",
          "phone": "0 8128-75 7-9338",
          "address": "Sudirman",
          "city": "Jakarta",
          "postal_code": "12190",
          "country_code": "IDN"
        }
      }
    });

    String username = 'SB-Mid-server-9z5jztsHyYxEdSs7DgkNg2on';
    String? password;
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      'authorization': basicAuth
    };

    var response = await http.post(
        Uri.parse('https://api.sandbox.midtrans.com/v2/charge'),
        body: data,
        headers: header);

    if (response.statusCode == 200) {
      var redirectUrl = jsonDecode(response.body)['redirect_url'];

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MidtransPaymentWebviewPage(
            redirectUrl: redirectUrl,
          ),
        ),
      );
    } else {
      print(response.body);
    }
  }
}
