// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/pay_services/billplz_service.dart';
import 'package:qixer/service/pay_services/cashfree_service.dart';
import 'package:qixer/service/pay_services/cinetpay_service.dart';
import 'package:qixer/service/pay_services/flutterwave_service.dart';
import 'package:qixer/service/pay_services/instamojo_service.dart';
import 'package:qixer/service/pay_services/mercado_pago_service.dart';
import 'package:qixer/service/pay_services/midtrans_service.dart';
import 'package:qixer/service/pay_services/mollie_service.dart';
import 'package:qixer/service/pay_services/payfast_service.dart';
import 'package:qixer/service/pay_services/paypal_service.dart';
import 'package:qixer/service/pay_services/paystack_service.dart';
import 'package:qixer/service/pay_services/paytabs_service.dart';
import 'package:qixer/service/pay_services/paytm_service.dart';

import 'package:qixer/service/pay_services/razorpay_service.dart';
import 'package:qixer/service/pay_services/square_service.dart';
import 'package:qixer/service/pay_services/stripe_service.dart';
import 'package:qixer/service/pay_services/zitopay_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

randomOrderId() {
  var rng = Random();
  return rng.nextInt(100).toString();
}

payAction(String method, BuildContext context, imagePath,
    {bool isFromOrderExtraAccept = false}) {
  //to know method names visit PaymentGatewayListService class where payment
  //methods list are fetching with method name

  switch (method) {
    case 'paypal':
      if (isFromOrderExtraAccept == true) {
        PaypalService().payByPaypal(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          PaypalService().payByPaypal(context);
        });
      }

      break;
    case 'cashfree':
      if (isFromOrderExtraAccept == true) {
        CashfreeService().getTokenAndPay(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          CashfreeService().getTokenAndPay(context);
        });
      }

      break;
    case 'flutterwave':
      if (isFromOrderExtraAccept == true) {
        FlutterwaveService()
            .payByFlutterwave(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          FlutterwaveService().payByFlutterwave(context);
        });
      }

      break;
    case 'instamojo':
      if (isFromOrderExtraAccept == true) {
        InstamojoService()
            .payByInstamojo(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          InstamojoService().payByInstamojo(context);
        });
      }

      break;
    case 'marcadopago':
      if (isFromOrderExtraAccept == true) {
        MercadoPagoService()
            .payByMercado(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          MercadoPagoService().payByMercado(context);
        });
      }

      break;
    case 'midtrans':
      if (isFromOrderExtraAccept == true) {
        MidtransService().payByMidtrans(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          MidtransService().payByMidtrans(context);
        });
      }

      break;
    case 'mollie':
      if (isFromOrderExtraAccept == true) {
        MollieService().payByMollie(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          MollieService().payByMollie(context);
        });
      }

      break;

    case 'payfast':
      if (isFromOrderExtraAccept == true) {
        PayfastService().payByPayfast(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          PayfastService().payByPayfast(context);
        });
      }

      break;

    case 'paystack':
      if (isFromOrderExtraAccept == true) {
        PaystackService().payByPaystack(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          PaystackService().payByPaystack(context);
        });
      }

      break;
    case 'paytm':
      if (isFromOrderExtraAccept == true) {
        PaytmService().payByPaytm(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          PaytmService().payByPaytm(context);
        }, paytmPaymentSelected: true);
      }

      break;

    case 'razorpay':
      if (isFromOrderExtraAccept == true) {
        RazorpayService().payByRazorpay(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          RazorpayService().payByRazorpay(context);
        });
      }

      break;
    case 'stripe':
      if (isFromOrderExtraAccept == true) {
        StripeService().makePayment(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          StripeService().makePayment(context);
        });
      }

      break;

    case 'squareup':
      if (isFromOrderExtraAccept == true) {
        SquareService().payBySquare(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          SquareService().payBySquare(context);
        });
      }

      break;

    case 'cinetpay':
      if (isFromOrderExtraAccept == true) {
        CinetPayService().payByCinetpay(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          CinetPayService().payByCinetpay(context);
        });
      }

      break;

    case 'paytabs':
      if (isFromOrderExtraAccept == true) {
        PaytabsService().payByPaytabs(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          PaytabsService().payByPaytabs(context);
        });
      }

      break;

    case 'billplz':
      if (isFromOrderExtraAccept == true) {
        BillPlzService().payByBillPlz(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          BillPlzService().payByBillPlz(context);
        });
      }

      break;

    case 'zitopay':
      if (isFromOrderExtraAccept == true) {
        ZitopayService().payByZitopay(context, isFromOrderExtraAccept: true);
      } else {
        makePaymentToGetOrderId(context, () {
          ZitopayService().payByZitopay(context);
        });
      }

      break;

    case 'manual_payment':
      if (imagePath == null) {
        OthersHelper()
            .showToast('You must upload the cheque image', Colors.black);
      } else {
        if (isFromOrderExtraAccept == true) {
          buyExtraCodOrManualPayment(context,
              manualPaymentSelected: true, imagePath: imagePath.path);
        } else {
          Provider.of<PlaceOrderService>(context, listen: false)
              .placeOrder(context, imagePath.path, isManualOrCod: true);
        }
      }

      break;
    case 'cash_on_delivery':
      if (isFromOrderExtraAccept == true) {
        buyExtraCodOrManualPayment(context);
      } else {
        Provider.of<PlaceOrderService>(context, listen: false)
            .placeOrder(context, null, isManualOrCod: true);
      }

      break;
    default:
      {
        debugPrint('not method found');
      }
  }
}

makePaymentToGetOrderId(BuildContext context, VoidCallback function,
    {bool paytmPaymentSelected = false}) async {
  var res = await Provider.of<PlaceOrderService>(context, listen: false)
      .placeOrder(context, null, paytmPaymentSelected: paytmPaymentSelected);

  if (res == true) {
    function();
  } else {
    print('order place unsuccessfull, visit payment_constants.dart file');
  }
}

buyExtraCodOrManualPayment(BuildContext context,
    {bool manualPaymentSelected = false, imagePath}) async {
  Provider.of<PlaceOrderService>(context, listen: false).setLoadingTrue();

  await Provider.of<OrderDetailsService>(context, listen: false)
      .acceptOrderExtra(context,
          manualPaymentSelected: manualPaymentSelected, imagePath: imagePath);
}
