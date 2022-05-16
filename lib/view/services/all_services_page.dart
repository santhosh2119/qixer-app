import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/services/components/service_filter_dropdowns.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../home/components/service_card.dart';

class AllServicePage extends StatefulWidget {
  const AllServicePage({Key? key}) : super(key: key);

  @override
  State<AllServicePage> createState() => _AllServicePageState();
}

class _AllServicePageState extends State<AllServicePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllServicesService>(context, listen: false)
        .fetchCategories(context);

    Provider.of<AllServicesService>(context, listen: false)
        .fetchServiceByFilter();
  }

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
              builder: (context, provider, child) => Column(
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      //Dropdown ==========>
                      const ServiceFilterDropdowns(),

                      provider.serviceMap.isNotEmpty
                          ? provider.serviceMap[0] != 'error'
                              ? Column(children: [
                                  // Service List ===============>
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  for (int i = 0;
                                      i < provider.serviceMap.length;
                                      i++)
                                    Column(
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
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
                                                    provider.serviceMap[i]
                                                        ['serviceId']);
                                          },
                                          child: ServiceCard(
                                            cc: cc,
                                            imageLink: provider.serviceMap[i]
                                                    ['image'] ??
                                                placeHolderUrl,
                                            rating: twoDouble(provider
                                                .serviceMap[i]['rating']),
                                            title: provider.serviceMap[i]
                                                ['title'],
                                            sellerName: provider.serviceMap[i]
                                                ['sellerName'],
                                            price: provider.serviceMap[i]
                                                ['price'],
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
                                                      ['price'],
                                                  provider.serviceMap[i]
                                                      ['sellerName'],
                                                  twoDouble(provider
                                                      .serviceMap[i]['rating']),
                                                  i,
                                                  context);
                                            },
                                            isSaved: provider.serviceMap[i]
                                                        ['isSaved'] ==
                                                    true
                                                ? true
                                                : false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                      ],
                                    )
                                ])
                              : Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 60),
                                  child: const Text("No service found"),
                                )
                          : Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 60),
                              child:
                                  OthersHelper().showLoading(cc.primaryColor),
                            ),
                    ],
                  )),
        ),
      ),
    );
  }
}
