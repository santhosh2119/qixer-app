import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class ServiceDetailsTop extends StatelessWidget {
  const ServiceDetailsTop({
    Key? key,
    required this.cc,
  }) : super(key: key);

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: cc.borderColor),
          top: BorderSide(width: 1, color: cc.borderColor),
        ),
      ),
      child: Row(children: [
        //orders completed ========>
        Expanded(
          child: Row(
            children: [
              Text(
                '38',
                style: TextStyle(
                    color: cc.successColor,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              AutoSizeText(
                'Orders completed',
                maxLines: 1,
                style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        //vertical border
        Container(
          height: 28,
          width: 1,
          margin: const EdgeInsets.only(left: 5, right: 15),
          color: cc.borderColor,
        ),
        //Sellers ratings ========>
        Expanded(
          child: Row(
            children: [
              Text(
                '98.6%',
                style: TextStyle(
                    color: cc.primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              AutoSizeText(
                'Seller Ratings',
                maxLines: 1,
                style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
