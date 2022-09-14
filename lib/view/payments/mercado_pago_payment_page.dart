import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MercadopagoPaymentPage extends StatefulWidget {
  MercadopagoPaymentPage({Key? key}) : super(key: key);

  @override
  State<MercadopagoPaymentPage> createState() => _MercadopagoPaymentPageState();
}

class _MercadopagoPaymentPageState extends State<MercadopagoPaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  late String url;

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Scaffold(
      appBar: AppBar(title: const Text('Mercado pago')),
      body: FutureBuilder(
          future: getPaymentUrl(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return const Center(
                child: Text('Loding failed.'),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                child: Text('Loding failed.'),
              );
            }
            return WebView(
              onWebResourceError: (error) => showDialog(
                  context: context,
                  builder: (ctx) {
                    return const AlertDialog(
                      title: const Text('Loading failed!'),
                      content: const Text('Failed to load payment page.'),
                      actions: [
                        Spacer(),
                      ],
                    );
                  }),
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (v) {
                print('on progress $v');
              },
              onWebViewCreated: (v) {
                // print('on webview created 'v.);
              },
              onPageFinished: (value) async {
                print('on progress.........................$value');
                if (value.contains('success')) {}
              },
              onPageStarted: (value) async {
                print("on progress.........................$value");
                if (value.contains('success')) {}
              },
            );
          }),
    );
  }

  Future<dynamic> getPaymentUrl(BuildContext context) async {
    var amount;

    var bcProvider =
        Provider.of<BookConfirmationService>(context, listen: false);
    var pProvider = Provider.of<PersonalizationService>(context, listen: false);
    var bookProvider = Provider.of<BookService>(context, listen: false);

    if (pProvider.isOnline == 0) {
      amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
    } else {
      amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation;
    }

    String mercadoKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .secretKey ??
            '';

    final orderId =
        Provider.of<PlaceOrderService>(context, listen: false).orderId;

    var email = bookProvider.email ?? '';

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var data = jsonEncode({
      "items": [
        {
          "title": "Qixer",
          "description": "Qixer payment",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": amount
        }
      ],
      "payer": {"email": email}
    });

    var response = await http.post(
        Uri.parse(
            'https://api.mercadopago.com/checkout/preferences?access_token=$mercadoKey'),
        headers: header,
        body: data);

    print(response.body);

    // print(response.body);
    if (response.statusCode == 201) {
      this.url = jsonDecode(response.body)['init_point'];

      return;
    }
    return '';
  }
}
