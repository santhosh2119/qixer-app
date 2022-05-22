import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/serachbar_with_dropdown_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/search/search_page.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/tabs/search/components/search_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../service/common_service.dart';
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
                child: Consumer<SearchBarWithDropdownService>(
                  builder: (context, provider, child) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        //Search bar and dropdown
                        Row(
                          children: [
                            Expanded(
                                // flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF5F5F5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.01),
                                              spreadRadius: -2,
                                              blurRadius: 13,
                                              offset: const Offset(0, 13)),
                                        ],
                                        borderRadius: BorderRadius.circular(3)),
                                    child: TextFormField(
                                      controller: searchController,
                                      autofocus: true,
                                      onFieldSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          provider.fetchService(context, value,
                                              provider.selectedCityId);
                                        }
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          provider.fetchService(context, value,
                                              provider.selectedCityId);
                                        }
                                      },
                                      style: const TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(Icons.search),
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                              color: cc.greyPrimary
                                                  .withOpacity(.8)),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.01),
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

                                          provider.fetchService(
                                              context,
                                              searchController.text,
                                              provider.selectedCityId);
                                        },
                                        items: provider.cityDropdownList
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
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

                        const SizedBox(
                          height: 30,
                        ),

                        //Services
                        provider.isLoading == false
                            ? provider.serviceMap.isNotEmpty
                                ? provider.serviceMap[0] != 'error'
                                    ? Column(
                                        children: [
                                          for (int i = 0;
                                              i < provider.serviceMap.length;
                                              i++)
                                            Column(
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute<void>(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const ServiceDetailsPage(),
                                                      ),
                                                    );
                                                    Provider.of<ServiceDetailsService>(
                                                            context,
                                                            listen: false)
                                                        .fetchServiceDetails(
                                                            provider.serviceMap[
                                                                    i]
                                                                ['serviceId']);
                                                  },
                                                  child: ServiceCard(
                                                    cc: cc,
                                                    imageLink:
                                                        provider.serviceMap[i]
                                                                ['image'] ??
                                                            placeHolderUrl,
                                                    rating: twoDouble(
                                                        provider.serviceMap[i]
                                                            ['rating']),
                                                    title: provider
                                                        .serviceMap[i]['title'],
                                                    sellerName:
                                                        provider.serviceMap[i]
                                                            ['sellerName'],
                                                    price: provider
                                                        .serviceMap[i]['price'],
                                                    buttonText: 'Book Now',
                                                    width: double.infinity,
                                                    marginRight: 0.0,
                                                    pressed: () {
                                                      provider.saveOrUnsave(
                                                          provider.serviceMap[i]
                                                              ['serviceId'],
                                                          provider.serviceMap[i]
                                                              ['title'],
                                                          provider.serviceMap[i]
                                                              ['image'],
                                                          provider.serviceMap[i]
                                                                  ['price']
                                                              .round(),
                                                          provider.serviceMap[i]
                                                              ['sellerName'],
                                                          twoDouble(provider
                                                                  .serviceMap[i]
                                                              ['rating']),
                                                          i,
                                                          context,
                                                          provider.serviceMap[i]
                                                              ['sellerId']);
                                                    },
                                                    isSaved: provider
                                                                    .serviceMap[
                                                                i]['isSaved'] ==
                                                            true
                                                        ? true
                                                        : false,
                                                    serviceId:
                                                        provider.serviceMap[i]
                                                            ['serviceId'],
                                                    sellerId:
                                                        provider.serviceMap[i]
                                                            ['sellerId'],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                              ],
                                            ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: Text(
                                              'No result found',
                                              style: TextStyle(
                                                  color: cc.greyPrimary),
                                            ),
                                          )
                                        ],
                                      )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          'No result found',
                                          style:
                                              TextStyle(color: cc.greyPrimary),
                                        ),
                                      )
                                    ],
                                  )
                            : OthersHelper().showLoading(cc.primaryColor),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
