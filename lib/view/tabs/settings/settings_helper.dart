import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class SettingsHelper {
  ConstantColors cc = ConstantColors();
  borderBold(double marginTop, double marginBottom) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      child: Divider(
        height: 0,
        thickness: 4,
        color: cc.borderColor,
      ),
    );
  }

  List<SettingsGridCard> cardContent = [
    SettingsGridCard('assets/svg/pending-circle.svg', 'Pending orders'),
    SettingsGridCard('assets/svg/active-circle.svg', 'Active orders'),
    SettingsGridCard('assets/svg/completed-circle.svg', 'Completed orders'),
    SettingsGridCard('assets/svg/receipt-circle.svg', 'Total orders'),
  ];

  settingOption(String icon, String title, VoidCallback pressed) {
    return ListTile(
      onTap: pressed,
      leading: SvgPicture.asset(
        icon,
        height: 35,
      ),
      title: Text(
        title,
        style: TextStyle(color: cc.greyFour, fontSize: 14),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 17,
      ),
    );
  }
}

class SettingsGridCard {
  String iconLink;
  String text;

  SettingsGridCard(this.iconLink, this.text);
}
