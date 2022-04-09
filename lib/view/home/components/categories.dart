import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.cc,
  }) : super(key: key);
  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 125,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < 8; i++)
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: 100,
                margin: const EdgeInsets.only(
                  right: 17,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: cc.borderColor),
                    borderRadius: BorderRadius.circular(9)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                child: Column(
                  children: [
                    Container(
                        height: 45,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://cdn.pixabay.com/photo/2020/04/24/11/44/coronavirus-5086544_960_720.png',
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fitHeight,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Electronic Service',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
