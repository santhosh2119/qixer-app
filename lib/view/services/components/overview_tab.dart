import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../../utils/common_helper.dart';
import '../service_helper.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less.',
          style: TextStyle(
            color: cc.greyParagraph,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          'What you will get:',
          maxLines: 1,
          style: TextStyle(
              color: cc.greyFour, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        //checklist
        const SizedBox(
          height: 19,
        ),
        for (int i = 0; i < 3; i++)
          ServiceHelper().checkListCommon('Weeding soft layer makeup'),
        //Benefit ===============>

        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          'Benefits of the premium package:',
          maxLines: 1,
          style: TextStyle(
              color: cc.greyFour, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        //checklist
        const SizedBox(
          height: 19,
        ),
        for (int i = 0; i < 3; i++)
          ServiceHelper().checkListCommon('Face+Body massage free'),

        const SizedBox(
          height: 20,
        ),
        CommonHelper().dividerCommon(),
//Button
        const SizedBox(
          height: 30,
        ),
        CommonHelper().buttonOrange("Book Appointment", () {}),
      ]),
    );
  }
}
