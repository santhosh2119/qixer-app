import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class Quantity extends StatelessWidget {
  const Quantity({
    Key? key,
    required this.cc,
  }) : super(key: key);

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Weeding soft layer makeup',
              style: TextStyle(
                color: cc.greyParagraph,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 9),
            child: Row(
              children: [
                Text(
                  '\$100 x',
                  style: TextStyle(
                    color: cc.greyPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  margin: const EdgeInsets.only(left: 7),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: cc.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.red.withOpacity(.12),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            color: Colors.red,
                            size: 19,
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "1",
                                style: TextStyle(
                                    color: cc.greyPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ))),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: cc.successColor.withOpacity(.12),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            color: cc.successColor,
                            size: 19,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
