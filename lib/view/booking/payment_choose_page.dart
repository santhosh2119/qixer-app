import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/booking/payment_success_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class PaymentChoosePage extends StatefulWidget {
  const PaymentChoosePage({Key? key}) : super(key: key);

  @override
  _PaymentChoosePageState createState() => _PaymentChoosePageState();
}

class _PaymentChoosePageState extends State<PaymentChoosePage> {
  @override
  void initState() {
    super.initState();
  }

  int selectedMethod = 0;
  bool termsAgree = false;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Payment', context),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //border
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: CommonHelper().dividerCommon(),
              ),
              BookingHelper().detailsPanelRow('Total Payable', 0, '237.6'),

              //border
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: CommonHelper().dividerCommon(),
              ),

              const SizedBox(
                height: 5,
              ),

              CommonHelper().titleCommon('Choose payment method'),

              //payment method card
              GridView.builder(
                gridDelegate: const FlutterzillaFixedGridView(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    height: 60),
                padding: const EdgeInsets.only(top: 30),
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedMethod = index;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: selectedMethod == index
                                    ? cc.primaryColor
                                    : cc.borderColor),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icons/paypal.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        selectedMethod == index
                            ? Positioned(
                                right: -7,
                                top: -9,
                                child: CommonHelper().checkCircle())
                            : Container()
                      ],
                    ),
                  );
                },
              ),

              //Agreement checkbox ===========>
              const SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: ConstantColors().primaryColor,
                contentPadding: const EdgeInsets.all(0),
                title: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "I agree with terms and conditions",
                    style: TextStyle(
                        color: ConstantColors().greyFour,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
                value: termsAgree,
                onChanged: (newValue) {
                  setState(() {
                    termsAgree = !termsAgree;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              //pay button =============>
              const SizedBox(
                height: 20,
              ),
              CommonHelper().buttonOrange('Pay & Confirm order', () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const PaymentSuccessPage(),
                  ),
                );
              })
            ]),
          ),
        ));
  }
}
