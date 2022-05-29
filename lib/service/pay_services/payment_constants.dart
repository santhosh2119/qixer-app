import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/pay_services/cashfree_service.dart';
import 'package:qixer/service/pay_services/flutterwave_service.dart';
import 'package:qixer/service/pay_services/instamojo_service.dart';
import 'package:qixer/service/pay_services/paypal_service.dart';
import 'package:qixer/service/pay_services/paystack_service.dart';
import 'package:qixer/service/pay_services/razorpay_service.dart';
import 'package:qixer/service/pay_services/stripe_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

randomOrderId() {
  var rng = Random();
  return rng.nextInt(100).toString();
}

payAction(String method, BuildContext context, imagePath) {
  switch (method) {
    case 'paypal':
      PaypalService().payByPaypal(context);
      break;
    case 'cashfree':
      CashfreeService().getTokenAndPay(context);
      break;
    case 'flutterwave':
      FlutterwaveService().payByFlutterwave(context);
      break;
    case 'instamojo':
      InstamojoService().payByInstamojo(context);
      break;
    case 'mercado':
      // CashfreeService().getTokenAndPay();
      break;
    case 'midtrans':
      // CashfreeService().getTokenAndPay();
      break;
    case 'mollie':
      // CashfreeService().getTokenAndPay();
      break;
    case 'payfast':
      // MercadoPagoService().mercadoPay();
      break;
    case 'paystack':
      PaystackService().payByPaystack(context);
      break;
    case 'paytm':
      // MercadoPagoService().mercadoPay();
      break;
    case 'razorpay':
      RazorpayService().payByRazorpay(context);
      break;
    case 'stripe':
      StripeService().makePayment(context);
      break;
    case 'bank_transfer':
      if (imagePath == null) {
        OthersHelper()
            .showToast('You must upload the cheque image', Colors.black);
      } else {
        Provider.of<PlaceOrderService>(context, listen: false)
            .placeOrder(context, imagePath.path);
      }
      // StripeService().makePayment(context);
      break;
    case 'cash_on_delivery':
      Provider.of<PlaceOrderService>(context, listen: false)
          .placeOrder(context, null);
      break;
    default:
      {
        debugPrint('not method found');
      }
  }
}

List paymentList = [
  PayMethods('paypal', 'assets/icons/payment/paypal.png'),
  PayMethods('cashfree', 'assets/icons/payment/cashfree.png'),
  PayMethods('flutterwave', 'assets/icons/payment/flutterwave.png'),
  PayMethods('instamojo', 'assets/icons/payment/instamojo.png'),
  PayMethods('mercado', 'assets/icons/payment/mercado.png'),
  PayMethods('midtrans', 'assets/icons/payment/midtrans.png'),
  PayMethods('mollie', 'assets/icons/payment/mollie.png'),
  PayMethods('payfast', 'assets/icons/payment/payfast.png'),
  PayMethods('paystack', 'assets/icons/payment/paystack.png'),
  PayMethods('paytm', 'assets/icons/payment/paytm.png'),
  PayMethods('razorpay', 'assets/icons/payment/razorpay.png'),
  PayMethods('stripe', 'assets/icons/payment/stripe.png'),
  PayMethods('bank_transfer', 'assets/icons/payment/bank_transfer.png'),
  PayMethods('cash_on_delivery', 'assets/icons/payment/cash_on_delivery.png'),
];

class PayMethods {
  final methodName;
  final image;

  PayMethods(this.methodName, this.image);
}