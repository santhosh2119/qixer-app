import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:qixer/service/pay_services/cashfree_service.dart';
import 'package:qixer/service/pay_services/mercado_pago_service.dart';

randomOrderId() {
  var rng = Random();
  return rng.nextInt(100).toString();
}

payAction(String method) {
  switch (method) {
    case 'cashfree':
      CashfreeService().getTokenAndPay();
      break;
    case 'mercado':
      MercadoPagoService().mercadoPay();
      break;
    case 'midtrans':
      MercadoPagoService().mercadoPay();
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
];

class PayMethods {
  final methodName;
  final image;

  PayMethods(this.methodName, this.image);
}
