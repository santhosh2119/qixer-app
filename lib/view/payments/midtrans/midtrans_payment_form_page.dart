import 'package:flutter/material.dart';
import 'package:qixer/service/pay_services/midtrans_service.dart';
import 'package:qixer/view/utils/custom_input.dart';

class MidtransPaymentFormPage extends StatefulWidget {
  const MidtransPaymentFormPage({Key? key}) : super(key: key);

  @override
  State<MidtransPaymentFormPage> createState() =>
      _MidtransPaymentFormPageState();
}

class _MidtransPaymentFormPageState extends State<MidtransPaymentFormPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(children: [
              //card number
              CustomInput(
                controller: cardNumberController,
                paddingHorizontal: 17,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                hintText: "Card number",
                textInputAction: TextInputAction.next,
                isNumberField: true,
              ),

              //month
              CustomInput(
                controller: monthController,
                paddingHorizontal: 17,
                maxLength: 2,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiration month';
                  } else if (value.length < 2) {
                    return 'Minimum character length is 2';
                  }

                  return null;
                },
                hintText: "Expiration Month",
                textInputAction: TextInputAction.next,
                isNumberField: true,
              ),

              //year
              CustomInput(
                controller: yearController,
                paddingHorizontal: 17,
                maxLength: 2,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your year';
                  } else if (value.length < 2) {
                    return 'Minimum character length is 2';
                  }
                  return null;
                },
                hintText: "Expiration Year",
                textInputAction: TextInputAction.next,
                isNumberField: true,
              ),

              //cvv
              CustomInput(
                controller: cvvController,
                paddingHorizontal: 17,
                maxLength: 3,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your cvv';
                  }
                  return null;
                },
                hintText: "CVV",
                textInputAction: TextInputAction.next,
                isNumberField: true,
              ),

              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                    MidtransService().getCardToken(context);
                  },
                  child: const Text('Pay'))
            ]),
          ),
        ),
      ),
    );
  }
}
