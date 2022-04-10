import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../../utils/common_helper.dart';
import '../service_helper.dart';

class AboutSellerTab extends StatelessWidget {
  const AboutSellerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //profile image, name and completed orders
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                placeholder: (context, url) {
                  return Image.asset('assets/images/placeholder.png');
                },
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nazmul Hoque',
                  style: TextStyle(
                      color: cc.greyFour,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      'Order Completed (6)',
                      style: TextStyle(
                        color: cc.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: cc.borderColor, width: 1),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ServiceHelper().serviceDetails('From', 'Bangladesh'),
                  ),
                  Expanded(
                      child: ServiceHelper()
                          .serviceDetails('Order Completion Rate', '86%'))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        ServiceHelper().serviceDetails('Seller Since', '2021'),
                  ),
                  Expanded(
                      child: ServiceHelper()
                          .serviceDetails('Order Completed', '6'))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less.',
                style: TextStyle(
                  color: cc.greyParagraph,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
