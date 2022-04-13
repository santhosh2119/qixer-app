import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class SettingsHelper {
  ConstantColors cc = ConstantColors();
  borderBold() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
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
}

class SettingsGridCard {
  String iconLink;
  String text;

  SettingsGridCard(this.iconLink, this.text);
}
