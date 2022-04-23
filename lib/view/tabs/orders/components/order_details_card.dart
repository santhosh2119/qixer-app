import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    Key? key,
    required this.cc,
    this.mainTitle,
    this.detailsList,
  }) : super(key: key);

  final ConstantColors cc;
  final mainTitle;
  final detailsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(9)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CommonHelper().titleCommon(mainTitle),
        const SizedBox(
          height: 25,
        ),
        //Service row
        for (int i = 0; i < 3; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      'Weeding soft layer makeup lar makeup',
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      '10x3',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      '\$200',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),

        //Divider
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 15),
          child: CommonHelper().dividerCommon(),
        ),

        //total price

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                color: cc.greyFour,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text('\$237.6',
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          ],
        )
      ]),
    );
  }
}
