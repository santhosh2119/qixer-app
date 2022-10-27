import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class OrderExtras extends StatelessWidget {
  const OrderExtras({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(9)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHelper().titleCommon('Extras'),
          const SizedBox(
            height: 20,
          ),
          for (int i = 0; i < 2; i++)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CommonHelper()
                  .titleCommon('Hair cut solution in your city', fontsize: 15),
              sizedBoxCustom(5),
              CommonHelper().paragraphCommon(
                  'Unit price: \$100    Quantity: 3    Total: \$100',
                  TextAlign.left),
              sizedBoxCustom(12),
              Row(
                children: [
                  Expanded(
                      child: CommonHelper().buttonOrange('Delete', () {},
                          bgColor: Colors.red, paddingVerticle: 14)),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CommonHelper().buttonOrange('Accept', () {},
                          bgColor: cc.successColor, paddingVerticle: 15)),
                ],
              ),
              sizedBoxCustom(22)
            ])
        ],
      ),
    );
  }
}
