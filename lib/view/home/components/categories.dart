import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.cc,
  }) : super(key: key);
  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    // getLineAwsome("las la-charging-station");
    return Consumer<CategoryService>(
      builder: (context, provider, child) {
        return provider.categories != null
            ? provider.categories != 'error'
                ? Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      children: [
                        for (int i = 0;
                            i < provider.categories.category.length;
                            i++)
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 12),
                              child: Column(
                                children: [
                                  // Container(
                                  //     height: 45,
                                  //     width: double.infinity,
                                  //     child: CachedNetworkImage(
                                  //       imageUrl:
                                  //           'https://cdn.pixabay.com/photo/2020/04/24/11/44/coronavirus-5086544_960_720.png',
                                  //       errorWidget: (context, url, error) =>
                                  //           const Icon(Icons.error),
                                  //       fit: BoxFit.fitHeight,
                                  //     )),
                                  // Icon(
                                  //   IconData(int.parse('0xf2a7'),
                                  //       fontFamily: 'LineAwesomeIcons',
                                  //       fontPackage: 'line_awesome_flutter'),
                                  //   color: cc.primaryColor,
                                  //   size: 33,
                                  // ),

                                  Icon(
                                    categoryIconList(i),
                                    color: cc.primaryColor,
                                    size: 33,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    provider.categories.category[i].name,
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
                  )
                : const Text("Something went wrong")
            : OthersHelper().showLoading(cc.primaryColor);
      },
    );
  }
}
