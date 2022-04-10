import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../utils/common_helper.dart';
import '../../utils/constant_colors.dart';

class Steps extends StatelessWidget {
  const Steps({
    Key? key,
    required this.cc,
  }) : super(key: key);

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SleekCircularSlider(
          appearance: CircularSliderAppearance(
              size: 85,
              customColors: CustomSliderColors(
                  progressBarColor: cc.primaryColor,
                  trackColor: cc.greyFive,
                  hideShadow: true),
              customWidths: CustomSliderWidths(progressBarWidth: 9)),
          min: 10,
          max: 28,
          initialValue: 14,
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHelper().titleCommon('Choose Location'),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  'Next:',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: cc.greyFour.withOpacity(.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Available schedules',
                  style: TextStyle(
                    color: cc.greyParagraph,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
