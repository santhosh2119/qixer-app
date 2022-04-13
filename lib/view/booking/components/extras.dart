import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../services/service_helper.dart';
import '../../utils/common_helper.dart';
import '../../utils/constant_colors.dart';

class Extras extends StatefulWidget {
  const Extras({Key? key, required this.cc}) : super(key: key);
  final ConstantColors cc;

  @override
  State<Extras> createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {
  List<int> selectedExtra = [0];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonHelper().titleCommon('Add extras:'),
        const SizedBox(
          height: 17,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 145,
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
                    setState(() {
                      if (selectedExtra.contains(i)) {
                        //if already added then remove
                        selectedExtra.remove(i);
                      } else {
                        selectedExtra.add(i);
                      }
                    });
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 200,
                        margin: const EdgeInsets.only(
                          right: 17,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: selectedExtra.contains(i)
                                    ? widget.cc.primaryColor
                                    : widget.cc.borderColor),
                            borderRadius: BorderRadius.circular(9)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Full Face Wash With Natural Cream',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: widget.cc.greyParagraph,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$100 x',
                                  style: TextStyle(
                                    color: widget.cc.greyPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: widget.cc.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                          color: widget.cc.greyFour,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://cdn.pixabay.com/photo/2013/07/12/17/41/lemon-152227_960_720.png',
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.fitHeight,
                                      height: 30,
                                      width: 40,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      selectedExtra.contains(i)
                          ? Positioned(
                              right: 12,
                              top: -8,
                              child: CommonHelper().checkCircle())
                          : Container(),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 27,
        ),
        CommonHelper().titleCommon('Benifits of the Package:'),
        const SizedBox(
          height: 17,
        ),
        for (int i = 0; i < 3; i++)
          ServiceHelper().checkListCommon('High Quality Products')
      ],
    );
  }
}
