import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class CommonHelper {
  ConstantColors cc = ConstantColors();
  //common appbar
  appbarCommon(String title, BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: cc.greyPrimary),
      title: Text(
        title,
        style: TextStyle(
            color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 18,
        ),
      ),
    );
  }

  //common orange button =======>
  buttonOrange(String title, VoidCallback pressed) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
              color: cc.primaryColor, borderRadius: BorderRadius.circular(8)),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          )),
    );
  }

  labelCommon(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(
          color: cc.greyThree,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  paragraphCommon(String title, TextAlign textAlign) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        color: cc.greyParagraph,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  titleCommon(String title) {
    return Text(
      title,
      style: TextStyle(
          color: cc.greyPrimary, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  dividerCommon() {
    return Divider(
      thickness: 1,
      height: 2,
      color: cc.borderColor,
    );
  }
}
