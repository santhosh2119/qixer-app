import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class StripeService with ChangeNotifier {
  String amount = '200';
  String publishableKey =
      'pk_test_51GwS1SEmGOuJLTMsIeYKFtfAT3o3Fc6IOC7wyFmmxA2FIFQ3ZigJ2z1s4ZOweKQKlhaQr1blTH9y6HR2PMjtq1Rx00vqE8LO0x';

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Map<String, dynamic>? paymentIntentData;

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print('stripe payment successfull');
        Provider.of<PlaceOrderService>(context, listen: false)
            .placeOrder(context);
        // print('payment id' + paymentIntentData!['id'].toString());
        // print('payment client secret' +
        //     paymentIntentData!['client_secret'].toString());
        // print('payment amount' + paymentIntentData!['amount'].toString());
        // print('payment intent full data' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        // OthersHelper().showToast("Payment Successful", Colors.black);

        //payment successs ================>

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        debugPrint('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      // print('Exception/DISPLAYPAYMENTSHEET==> $e');
      OthersHelper().showToast("Payment cancelled", Colors.red);
    } catch (e) {
      debugPrint('$e');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
    // return amount;
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency, context) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      // print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51GwS1SEmGOuJLTMs2vhSliTwAGkOt4fKJMBrxzTXeCJoLrRu8HFf4I0C5QuyE3l3bQHBJm3c0qFmeVjd0V9nFb6Z00VrWDJ9Uw',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      // print('Create Intent reponse ===> ${response.body.toString()}');
      // debugPrint("response body is ${response.body}");
      return jsonDecode(response.body);
    } catch (err) {
      debugPrint('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, 'USD', context);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.light,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(context);
    } catch (e, s) {
      debugPrint('exception:$e$s');
    }
  }
}
