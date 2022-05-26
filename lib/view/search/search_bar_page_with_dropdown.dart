import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/serachbar_with_dropdown_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/search/components/search_bar.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../service/common_service.dart';
import '../utils/constant_colors.dart';

class SearchBarPageWithDropdown extends StatelessWidget {
  SearchBarPageWithDropdown({
    Key? key,
    required this.cc,
    this.isHomePage = false,
  }) : super(key: key);

  final bool isHomePage;

  final ConstantColors cc;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Search', context, () {
        Navigator.pop(context);
      }),
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonHelper().dividerCommon(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                margin: const EdgeInsets.only(top: 25),
                child: const SearchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
