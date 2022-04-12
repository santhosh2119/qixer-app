import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../../booking/booking_location_page.dart';

class TopRatedSellers extends StatelessWidget {
  const TopRatedSellers({
    Key? key,
    required this.cc,
  }) : super(key: key);
  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 190,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < 8; i++)
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ServiceDetailsPage(),
                  ),
                );
              },
              child: ServiceCard(
                cc: cc,
                imageLink:
                    "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                rating: '4.5',
                title: 'Hair cutting service at low price Hair cutting',
                sellerName: 'Jane Cooper',
                price: '30',
                buttonText: 'Book Now',
                width: MediaQuery.of(context).size.width - 85,
                marginRight: 17.0,
              ),
            )
        ],
      ),
    );
  }
}
