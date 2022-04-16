import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../home/components/service_card.dart';

class AllServicePage extends StatelessWidget {
  const AllServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('All Services', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Consumer<AllServicesService>(
            builder: (context, provider, child) => Column(children: [
              const SizedBox(
                height: 14,
              ),
              //Dropdown
              Row(
                children: [
                  // Category dropdown
                  provider.categoryDropdown.isNotEmpty
                      ? Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().labelCommon("Category"),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: cc.greyFive),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // menuMaxHeight: 200,
                                  // isExpanded: true,
                                  value: provider.selectedCategory,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: cc.greyFour),
                                  iconSize: 26,
                                  elevation: 17,
                                  style: TextStyle(color: cc.greyFour),
                                  onChanged: (newValue) {
                                    provider.setCategoryValue(newValue);

                                    //setting the id of selected value
                                    // provider.setId(
                                    //     provider.valueIndexList[
                                    //         provider.dropdown
                                    //             .indexOf(newValue)]);
                                  },
                                  items: provider.categoryDropdown
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color:
                                                cc.greyPrimary.withOpacity(.8)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ))
                      : Container(),

                  // ====================>
                  const SizedBox(
                    width: 20,
                  ),
                  // Sub Category dropdown
                  provider.subCategoryDropdown.isNotEmpty
                      ? Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().labelCommon("Sub Category"),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: cc.greyFive),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // menuMaxHeight: 200,
                                  // isExpanded: true,
                                  value: provider.selectedSubCategory,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: cc.greyFour),
                                  iconSize: 26,
                                  elevation: 17,
                                  style: TextStyle(color: cc.greyFour),
                                  onChanged: (newValue) {
                                    provider.setSubCategoryValue(newValue);

                                    //setting the id of selected value
                                    // provider.setId(
                                    //     provider.valueIndexList[
                                    //         provider.dropdown
                                    //             .indexOf(newValue)]);
                                  },
                                  items: provider.subCategoryDropdown
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color:
                                                cc.greyPrimary.withOpacity(.8)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ))
                      : Container()
                ],
              ),

              sizedBox20(),

              Row(
                children: [
                  // Ratings dropdown
                  provider.ratingsDropdown.isNotEmpty
                      ? Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().labelCommon("Ratings"),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: cc.greyFive),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // menuMaxHeight: 200,
                                  // isExpanded: true,
                                  value: provider.selectedRatings,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: cc.greyFour),
                                  iconSize: 26,
                                  elevation: 17,
                                  style: TextStyle(color: cc.greyFour),
                                  onChanged: (newValue) {
                                    provider.setRatingsValue(newValue);

                                    //setting the id of selected value
                                    // provider.setId(
                                    //     provider.valueIndexList[
                                    //         provider.dropdown
                                    //             .indexOf(newValue)]);
                                  },
                                  items: provider.ratingsDropdown
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color:
                                                cc.greyPrimary.withOpacity(.8)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ))
                      : Container(),

                  // ====================>
                  const SizedBox(
                    width: 20,
                  ),
                  // Sort by dropdown
                  provider.sortByDropdown.isNotEmpty
                      ? Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().labelCommon("Sub Category"),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: cc.greyFive),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // menuMaxHeight: 200,
                                  // isExpanded: true,
                                  value: provider.selectedSortBy,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: cc.greyFour),
                                  iconSize: 26,
                                  elevation: 17,
                                  style: TextStyle(color: cc.greyFour),
                                  onChanged: (newValue) {
                                    provider.setSortByValue(newValue);

                                    //setting the id of selected value
                                    // provider.setId(
                                    //     provider.valueIndexList[
                                    //         provider.dropdown
                                    //             .indexOf(newValue)]);
                                  },
                                  items: provider.sortByDropdown
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color:
                                                cc.greyPrimary.withOpacity(.8)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ))
                      : Container()
                ],
              ),

              // Service List ===============>
              const SizedBox(
                height: 35,
              ),
              for (int i = 0; i < 3; i++)
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ServiceDetailsPage(),
                          ),
                        );
                      },
                      child: ServiceCard(
                        cc: cc,
                        imageLink:
                            "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                        rating: '4.5',
                        title: 'Hair cutting service at low price Hair cutting',
                        sellerName: 'Jane Cooper',
                        price: '30',
                        buttonText: 'Book Now',
                        width: double.infinity,
                        marginRight: 0.0,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                )
            ]),
          ),
        ),
      ),
    );
  }
}
