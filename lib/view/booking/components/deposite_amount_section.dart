import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';

class DepositeAmountSection extends StatefulWidget {
  const DepositeAmountSection({Key? key}) : super(key: key);

  @override
  State<DepositeAmountSection> createState() => _DepositeAmountSectionState();
}

class _DepositeAmountSectionState extends State<DepositeAmountSection> {
  final amountController = TextEditingController();
  bool depositeFromCurrent = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<WalletService>(
        builder: (context, wProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Amount ============>
            CommonHelper().labelCommon(ln.getString("Deposite Amount")),

            sizedBoxCustom(5),
            CustomInput(
              controller: amountController,
              hintText: ln.getString("Enter deposite amount"),
              textInputAction: TextInputAction.next,
              paddingHorizontal: 18,
              onChanged: (v) {
                wProvider.setAmount(v);
              },
            ),

            CheckboxListTile(
              checkColor: Colors.white,
              activeColor: ConstantColors().primaryColor,
              contentPadding: const EdgeInsets.all(0),
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  ln.getString('Deposite from current balance'),
                  style: TextStyle(
                      color: ConstantColors().greyFour,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
              value: depositeFromCurrent,
              onChanged: (newValue) {
                setState(() {
                  depositeFromCurrent = !depositeFromCurrent;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }
}
