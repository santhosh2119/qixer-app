import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/view/payments/mercado_pago_payment_page.dart';

class MercadoPagoService {
  payByMercado(BuildContext context) {
    Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MercadopagoPaymentPage(),
      ),
    );
  }
}
