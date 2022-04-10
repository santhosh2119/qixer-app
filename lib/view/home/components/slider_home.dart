import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/constant_colors.dart';

class SliderHome extends StatelessWidget {
  const SliderHome({
    Key? key,
    required this.cc,
  }) : super(key: key);

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          initialPage: 1,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1509664158680-07c5032b51e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                left: 25,
                top: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '25% off on painting services',
                        style: TextStyle(
                            color: cc.greyFour,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Electronic Service',
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: cc.greyFour, elevation: 0),
                          onPressed: () {},
                          child: const Text('Get now'))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
