import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../utils/common_helper.dart';

class ServiceFilterDropdowns extends StatelessWidget {
  const ServiceFilterDropdowns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<AllServicesService>(
      builder: (context, provider, child) => Column(
        children: [
          Row(
            children: [
              // Category dropdown
              provider.categoryDropdownList.isNotEmpty
                  ? Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonHelper().labelCommon("Category"),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                provider.setSelectedCategoryId(
                                    provider.categoryDropdownIndexList[provider
                                        .categoryDropdownList
                                        .indexOf(newValue!)]);

                                //fetch states based on selected country
                                provider.fetchSubcategory(
                                    provider.selectedCategoryId);
                              },
                              items: provider.categoryDropdownList
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: cc.greyPrimary.withOpacity(.8)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [OthersHelper().showLoading(cc.primaryColor)],
                    ),

              // ====================>
              const SizedBox(
                width: 20,
              ),
              // Sub Category dropdown
              Expanded(
                child: provider.subcatDropdownList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper().labelCommon("Sub Category"),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: cc.greyFive),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // menuMaxHeight: 200,
                                // isExpanded: true,
                                value: provider.selectedSubcat,
                                icon: Icon(Icons.keyboard_arrow_down_rounded,
                                    color: cc.greyFour),
                                iconSize: 26,
                                elevation: 17,
                                style: TextStyle(color: cc.greyFour),
                                onChanged: (newValue) {
                                  provider.setSubcatValue(newValue);

                                  //setting the id of selected value
                                  provider.setSelectedSubcatsId(
                                      provider.subcatDropdownIndexList[provider
                                          .subcatDropdownList
                                          .indexOf(newValue!)]);

                                  //fetch service
                                  provider.fetchServiceByFilter();
                                },
                                items: provider.subcatDropdownList
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
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              )
            ],
          ),
          sizedBox20(),
          Row(
            children: [
              // Ratings dropdown
              Expanded(
                child: provider.ratingDropdownList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper().labelCommon("Ratings"),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: cc.greyFive),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // menuMaxHeight: 200,
                                // isExpanded: true,
                                value: provider.selectedRating,
                                icon: Icon(Icons.keyboard_arrow_down_rounded,
                                    color: cc.greyFour),
                                iconSize: 26,
                                elevation: 17,
                                style: TextStyle(color: cc.greyFour),
                                onChanged: (newValue) {
                                  provider.setRatingValue(newValue);

                                  //setting the id of selected value
                                  // provider.setId(
                                  //     provider.valueIndexList[
                                  //         provider.dropdown
                                  //             .indexOf(newValue)]);
                                },
                                items: provider.ratingDropdownList
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
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              ),

              // ====================>
              const SizedBox(
                width: 20,
              ),
              // Sort by dropdown
              provider.sortbyDropdownList.isNotEmpty
                  ? Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonHelper().labelCommon("Sort By"),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: cc.greyFive),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              // menuMaxHeight: 200,
                              // isExpanded: true,
                              value: provider.selectedSortby,
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: cc.greyFour),
                              iconSize: 26,
                              elevation: 17,
                              style: TextStyle(color: cc.greyFour),
                              onChanged: (newValue) {
                                provider.setSortbyValue(newValue);

                                //setting the id of selected value
                                // provider.setId(
                                //     provider.valueIndexList[
                                //         provider.dropdown
                                //             .indexOf(newValue)]);
                              },
                              items: provider.sortbyDropdownList
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: cc.greyPrimary.withOpacity(.8)),
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
        ],
      ),
    );
  }
}
