import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/jobs_service/job_create_dropdown_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class JobCreateDropdowns extends StatefulWidget {
  const JobCreateDropdowns({Key? key}) : super(key: key);

  @override
  State<JobCreateDropdowns> createState() => _JobCreateDropdownsState();
}

class _JobCreateDropdownsState extends State<JobCreateDropdowns> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<JobCreateDropdownService>(
        builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //dropdown and search box
                const SizedBox(
                  width: 17,
                ),

                // Category dropdown ===============>
                CommonHelper().labelCommon("Choose Category"),
                provider.categoryDropdownList.isNotEmpty
                    ? Container(
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

                              // setting the id of selected value
                              provider.setSelectedCategoryId(
                                  provider.categoryDropdownIndexList[provider
                                      .categoryDropdownList
                                      .indexOf(newValue!)]);
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),

                const SizedBox(
                  height: 25,
                ),

                // States dropdown ===============>
                CommonHelper().labelCommon("Choose Subcategory"),
                provider.subCategoryDropdownList.isNotEmpty
                    ? Container(
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
                            value: provider.selectedSubCategory,
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: cc.greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: TextStyle(color: cc.greyFour),
                            onChanged: (newValue) {
                              provider.setSubCategoryValue(newValue);

                              //setting the id of selected value
                              provider.setSelectedSubCategoryId(
                                  provider.subCategoryDropdownIndexList[provider
                                      .subCategoryDropdownList
                                      .indexOf(newValue!)]);
                            },
                            items: provider.subCategoryDropdownList
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),

                const SizedBox(
                  height: 25,
                ),

                // Country dropdown ===============>
                CommonHelper().labelCommon("Choose country"),
                provider.countryDropdownList.isNotEmpty
                    ? Container(
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
                            value: provider.selectedCountry,
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: cc.greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: TextStyle(color: cc.greyFour),
                            onChanged: (newValue) {
                              provider.setCountryValue(newValue);

                              //setting the id of selected value
                              provider.setSelectedCountryId(
                                  provider.countryDropdownIndexList[provider
                                      .countryDropdownList
                                      .indexOf(newValue!)]);
                            },
                            items: provider.countryDropdownList
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),

                const SizedBox(
                  height: 25,
                ),

                // City dropdown ===============>
                CommonHelper().labelCommon("Choose city"),
                provider.cityDropdownList.isNotEmpty
                    ? Container(
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
                            value: provider.selectedCity,
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: cc.greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: TextStyle(color: cc.greyFour),
                            onChanged: (newValue) {
                              provider.setCityValue(newValue);

                              //setting the id of selected value
                              provider.setSelectedCityId(
                                  provider.cityDropdownIndexList[provider
                                      .cityDropdownList
                                      .indexOf(newValue!)]);
                            },
                            items: provider.cityDropdownList
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              ],
            ));
  }
}
