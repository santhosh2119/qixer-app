import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/serachbar_with_dropdown_service.dart';
import 'package:qixer/view/search/search_page.dart';
import 'package:qixer/view/tabs/search/components/search_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';

import '../../utils/constant_colors.dart';

class SearchBarWithDropdown extends StatelessWidget {
  SearchBarWithDropdown({
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
      body: Column(
        children: [
          CommonHelper().dividerCommon(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            margin: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Consumer<SearchBarWithDropdownService>(
                  builder: (context, provider, child) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                            // flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffF5F5F5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.01),
                                          spreadRadius: -2,
                                          blurRadius: 13,
                                          offset: const Offset(0, 13)),
                                    ],
                                    borderRadius: BorderRadius.circular(3)),
                                child: TextFormField(
                                  controller: searchController,
                                  autofocus: true,
                                  onFieldSubmitted: (value) {},
                                  style: const TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                          color:
                                              cc.greyPrimary.withOpacity(.8)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 15)),
                                ))),

                        const SizedBox(
                          width: 17,
                        ),
                        // dropdown ===========
                        provider.cityDropdownList.isNotEmpty
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.01),
                                        spreadRadius: -2,
                                        blurRadius: 13,
                                        offset: const Offset(0, 13)),
                                  ],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    // menuMaxHeight: 200,
                                    // isExpanded: true,
                                    value: provider.selectedCity,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: cc.greyFour),
                                    iconSize: 26,
                                    elevation: 17,
                                    style: const TextStyle(
                                        color: Color(0xff646464)),
                                    onChanged: (newValue) {
                                      provider.setCityValue(newValue);

                                      // setting the id of selected value
                                      provider.setSelectedCityId(
                                          provider.cityDropdownIndexList[
                                              provider.cityDropdownList
                                                  .indexOf(newValue!)]);
                                    },
                                    items: provider.cityDropdownList
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: cc.greyPrimary
                                                  .withOpacity(.8)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
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
