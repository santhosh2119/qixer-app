// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/view/payments/zitopay_payment_page.dart';

class ZitopayService {
  payByZitopay(BuildContext context) {
    //========>
    Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    var amount;
    var bcProvider =
        Provider.of<BookConfirmationService>(context, listen: false);
    var pProvider = Provider.of<PersonalizationService>(context, listen: false);
    var userName =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .zitopayUserName;

    if (pProvider.isOnline == 0) {
      amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
    } else {
      amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
          .toStringAsFixed(2);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ZitopayPaymentPage(
          amount: amount,
          userName: userName,
        ),
      ),
    );
  }
}
