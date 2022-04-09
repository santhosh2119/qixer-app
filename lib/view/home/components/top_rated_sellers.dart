import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

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
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 85,
                margin: const EdgeInsets.only(
                  right: 17,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: cc.borderColor),
                    borderRadius: BorderRadius.circular(9)),
                padding: const EdgeInsets.fromLTRB(13, 15, 13, 8),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                                placeholder: (context, url) {
                                  return Image.asset(
                                      'assets/images/placeholder.png');
                                },
                                height: 75,
                                width: 78,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                bottom: -13,
                                left: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      color: const Color(0xffFFC300),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  child: Row(children: [
                                    Icon(
                                      Icons.star_border,
                                      color: cc.greyFour,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                          color: cc.greyFour,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    )
                                  ]),
                                )),
                          ],
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              //service name ======>
                              Text(
                                'Hair cutting service at low price Hair cutting',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: cc.greyFour,
                                  fontSize: 15,
                                  height: 1.4,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              //Author name
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'by:',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: cc.greyFour.withOpacity(.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Jane Cooper',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: cc.greyFour,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CommonHelper().dividerCommon(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              AutoSizeText(
                                'Starts from:',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: cc.greyFour.withOpacity(.6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              AutoSizeText(
                                '\$30',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: cc.greyFour,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 9),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: cc.borderColor),
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/svg/saved-icon.svg',
                            color: cc.greyFour,
                            height: 21,
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: cc.primaryColor,
                                shadowColor: Colors.transparent),
                            onPressed: () {},
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.normal),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
