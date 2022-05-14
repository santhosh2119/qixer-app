import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/serviceby_category_service.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../home/components/service_card.dart';

class ServicebyCategoryPage extends StatefulWidget {
  const ServicebyCategoryPage(
      {Key? key, this.categoryName = '', required this.categoryId})
      : super(key: key);

  final String categoryName;
  final categoryId;

  @override
  State<ServicebyCategoryPage> createState() => _ServicebyCategoryPageState();
}

class _ServicebyCategoryPageState extends State<ServicebyCategoryPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServiceByCategoryService>(context, listen: false)
        .fetchCategoryService(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon(widget.categoryName, context, () {
        Provider.of<ServiceByCategoryService>(context, listen: false)
            .makeListEmpty();
        Navigator.pop(context);
      }),
      body: WillPopScope(
        onWillPop: () {
          Provider.of<ServiceByCategoryService>(context, listen: false)
              .makeListEmpty();
          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Consumer<ServiceByCategoryService>(
              builder: (context, provider, child) => provider
                      .categoryServiceMap.isNotEmpty
                  ? provider.categoryServiceMap[0] != 'error'
                      ? Column(children: [
                          // Service List ===============>
                          const SizedBox(
                            height: 15,
                          ),
                          for (int i = 0;
                              i < provider.categoryServiceMap.length;
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
                                        builder: (BuildContext context) =>
                                            ServiceDetailsPage(),
                                      ),
                                    );
                                  },
                                  child: ServiceCard(
                                    cc: cc,
                                    imageLink: provider.categoryServiceMap[i]
                                            ['image'] ??
                                        placeHolderUrl,
                                    rating: twoDouble(provider
                                        .categoryServiceMap[i]['rating']),
                                    title: provider.categoryServiceMap[i]
                                        ['title'],
                                    sellerName: provider.categoryServiceMap[i]
                                        ['sellerName'],
                                    price: provider.categoryServiceMap[i]
                                        ['price'],
                                    buttonText: 'Book Now',
                                    width: double.infinity,
                                    marginRight: 0.0,
                                    pressed: () {
                                      provider.saveOrUnsave(
                                          provider.categoryServiceMap[i]
                                              ['serviceId'],
                                          provider.categoryServiceMap[i]
                                              ['title'],
                                          provider.categoryServiceMap[i]
                                              ['image'],
                                          provider.categoryServiceMap[i]
                                              ['price'],
                                          provider.categoryServiceMap[i]
                                              ['sellerName'],
                                          twoDouble(provider
                                              .categoryServiceMap[i]['rating']),
                                          i,
                                          context);
                                    },
                                    isSaved: provider.categoryServiceMap[i]
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
                      : const Text("Something went wrong")
                  : OthersHelper().showLoading(cc.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
