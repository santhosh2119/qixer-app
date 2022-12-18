// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

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
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

payAction(String method, BuildContext context, imagePath,
    {bool isFromOrderExtraAccept = false,
    bool isFromWalletDeposite = false,
    bool payAgain = false}) {
  //to know method names visit PaymentGatewayListService class where payment
  //methods list are fetching with method name

  switch (method) {
    case 'paypal':
      if (isFromOrderExtraAccept) {
        PaypalService().payByPaypal(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaypalService().payByPaypal(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          PaypalService().payByPaypal(context);
        }, payAgain: payAgain);
      }

      break;
    case 'cashfree':
      if (isFromOrderExtraAccept == true) {
        CashfreeService().getTokenAndPay(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          CashfreeService().getTokenAndPay(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          CashfreeService().getTokenAndPay(context);
        }, payAgain: payAgain);
      }

      break;
    case 'flutterwave':
      if (isFromOrderExtraAccept == true) {
        FlutterwaveService()
            .payByFlutterwave(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          FlutterwaveService()
              .payByFlutterwave(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          FlutterwaveService().payByFlutterwave(context);
        }, payAgain: payAgain);
      }

      break;
    case 'instamojo':
      if (isFromOrderExtraAccept == true) {
        InstamojoService()
            .payByInstamojo(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          InstamojoService()
              .payByInstamojo(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          InstamojoService().payByInstamojo(context);
        }, payAgain: payAgain);
      }

      break;
    case 'marcadopago':
      if (isFromOrderExtraAccept == true) {
        MercadoPagoService()
            .payByMercado(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          MercadoPagoService()
              .payByMercado(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          MercadoPagoService().payByMercado(context);
        }, payAgain: payAgain);
      }

      break;
    case 'midtrans':
      if (isFromOrderExtraAccept == true) {
        MidtransService().payByMidtrans(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          MidtransService().payByMidtrans(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          MidtransService().payByMidtrans(context);
        }, payAgain: payAgain);
      }

      break;
    case 'mollie':
      if (isFromOrderExtraAccept == true) {
        MollieService().payByMollie(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          MollieService().payByMollie(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          MollieService().payByMollie(context);
        }, payAgain: payAgain);
      }

      break;

    case 'payfast':
      if (isFromOrderExtraAccept == true) {
        PayfastService().payByPayfast(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PayfastService().payByPayfast(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          PayfastService().payByPayfast(context);
        }, payAgain: payAgain);
      }

      break;

    case 'paystack':
      if (isFromOrderExtraAccept == true) {
        PaystackService().payByPaystack(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaystackService().payByPaystack(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          PaystackService().payByPaystack(context);
        }, payAgain: payAgain);
      }

      break;
    case 'paytm':
      if (isFromOrderExtraAccept == true) {
        PaytmService().payByPaytm(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaytmService().payByPaytm(context, isFromWalletDeposite: true);
        }, paytmPaymentSelected: true);
      } else {
        makePaymentToGetOrderId(context, () {
          PaytmService().payByPaytm(context);
        }, paytmPaymentSelected: true, payAgain: payAgain);
      }

      break;

    case 'razorpay':
      if (isFromOrderExtraAccept == true) {
        RazorpayService().payByRazorpay(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          RazorpayService().payByRazorpay(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          RazorpayService().payByRazorpay(context);
        }, payAgain: payAgain);
      }

      break;
    case 'stripe':
      if (isFromOrderExtraAccept == true) {
        StripeService().makePayment(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          StripeService().makePayment(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          StripeService().makePayment(context);
        }, payAgain: payAgain);
      }

      break;

    case 'squareup':
      if (isFromOrderExtraAccept == true) {
        SquareService().payBySquare(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          SquareService().payBySquare(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          SquareService().payBySquare(context);
        }, payAgain: payAgain);
      }

      break;

    case 'cinetpay':
      if (isFromOrderExtraAccept == true) {
        CinetPayService().payByCinetpay(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          CinetPayService().payByCinetpay(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          CinetPayService().payByCinetpay(context);
        }, payAgain: payAgain);
      }

      break;

    case 'paytabs':
      if (isFromOrderExtraAccept == true) {
        PaytabsService().payByPaytabs(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaytabsService().payByPaytabs(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          PaytabsService().payByPaytabs(context);
        }, payAgain: payAgain);
      }

      break;

    case 'billplz':
      if (isFromOrderExtraAccept == true) {
        BillPlzService().payByBillPlz(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          BillPlzService().payByBillPlz(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          BillPlzService().payByBillPlz(context);
        }, payAgain: payAgain);
      }

      break;

    case 'zitopay':
      if (isFromOrderExtraAccept == true) {
        ZitopayService().payByZitopay(context, isFromOrderExtraAccept: true);
      } else if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          ZitopayService().payByZitopay(context, isFromWalletDeposite: true);
        });
      } else {
        makePaymentToGetOrderId(context, () {
          ZitopayService().payByZitopay(context);
        }, payAgain: payAgain);
      }

      break;

    case 'manual_payment':
      if (payAgain) {
        OthersHelper().showToast(
            'Manual payment is not available for second attempt payment',
            Colors.black);
        return;
      }

      if (imagePath == null) {
        OthersHelper()
            .showToast('You must upload the cheque image', Colors.black);
        return;
      }

      if (isFromOrderExtraAccept == true) {
        buyExtraCodOrManualPayment(context,
            manualPaymentSelected: true, imagePath: imagePath.path);
      } else if (isFromWalletDeposite) {
        Provider.of<WalletService>(context, listen: false)
            .createDepositeRequest(context,
                imagePath: imagePath.path, isManualOrCod: true);
      } else {
        Provider.of<PlaceOrderService>(context, listen: false)
            .placeOrder(context, imagePath.path, isManualOrCod: true);
      }

      break;
    case 'cash_on_delivery':
      if (payAgain) {
        OthersHelper().showToast(
            'Cash on delivery is not available for second attempt payment',
            Colors.black);
        return;
      }

      if (isFromOrderExtraAccept == true) {
        buyExtraCodOrManualPayment(context);
      } else if (isFromWalletDeposite) {
        Provider.of<WalletService>(context, listen: false)
            .createDepositeRequest(context,
                imagePath: null, isManualOrCod: true);
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
    {bool paytmPaymentSelected = false, bool payAgain = false}) async {
  var res = true;
  if (payAgain == false) {
    res = await Provider.of<PlaceOrderService>(context, listen: false)
        .placeOrder(context, null, paytmPaymentSelected: paytmPaymentSelected);
  }
  //
  if (res == true) {
    function();
  } else {
    print('order place unsuccessfull, visit payment_constants.dart file');
  }
}

//=============>
createDepositeRequestAndPay(BuildContext context, VoidCallback function,
    {bool paytmPaymentSelected = false}) async {
  var res = await Provider.of<WalletService>(context, listen: false)
      .createDepositeRequest(context,
          imagePath: null, paytmPaymentSelected: paytmPaymentSelected);

  if (res == true) {
    function();
  } else {
    print('adding balance to wallet unsuccessfull');
  }
}

//===========>

buyExtraCodOrManualPayment(BuildContext context,
    {bool manualPaymentSelected = false, imagePath}) async {
  Provider.of<PlaceOrderService>(context, listen: false).setLoadingTrue();

  await Provider.of<OrderDetailsService>(context, listen: false)
      .acceptOrderExtra(context,
          manualPaymentSelected: manualPaymentSelected, imagePath: imagePath);
}

//============>