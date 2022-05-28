import 'package:flutter/material.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../services/service_by_category_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      required this.name,
      required this.id,
      required this.cc,
      required this.index,
      required this.marginRight})
      : super(key: key);

  final name;
  final id;
  final cc;
  final index;
  final double marginRight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ServicebyCategoryPage(
              categoryName: name,
              categoryId: id,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        margin: EdgeInsets.only(
          right: marginRight,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: cc.borderColor),
            borderRadius: BorderRadius.circular(9)),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
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
              categoryIconList(index),
              color: cc.primaryColor,
              size: 33,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
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
    );
  }
}
