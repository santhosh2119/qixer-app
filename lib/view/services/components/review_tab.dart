import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List reviewList = ['a', 'b', 'c'];
    ConstantColors cc = ConstantColors();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //profile image, rating, feedback
      for (int i = 0; i < reviewList.length; i++)
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
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
                        height: 10,
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              Icons.star,
                              color: cc.primaryColor,
                              size: 16,
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //feedback
                      Text(
                        'Good quality Service',
                        style: TextStyle(
                          color: cc.greyParagraph,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),

                      //date
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mar 21, 2022',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.8),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //Border bottom
              const SizedBox(
                height: 20,
              ),
              i != reviewList.length - 1
                  ? CommonHelper().dividerCommon()
                  : Container(),
            ],
          ),
        ),
    ]);
  }
}
