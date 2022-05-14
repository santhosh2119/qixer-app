import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class RecentServices extends StatelessWidget {
  const RecentServices({
    Key? key,
    required this.cc,
  }) : super(key: key);
  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentServicesService>(
      builder: (context, provider, child) => provider
              .recentServiceMap.isNotEmpty
          ? provider.recentServiceMap[0] != 'error'
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 190,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < provider.recentServiceMap.length; i++)
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
                            imageLink: provider.recentServiceMap[i]['image'] ??
                                placeHolderUrl,
                            rating: twoDouble(
                                provider.recentServiceMap[i]['rating']),
                            title: provider.recentServiceMap[i]['title'],
                            sellerName: provider.recentServiceMap[i]
                                ['sellerName'],
                            price: provider.recentServiceMap[i]['price'],
                            buttonText: 'Book Now',
                            width: MediaQuery.of(context).size.width - 85,
                            marginRight: 17.0,
                            pressed: () {
                              provider.saveOrUnsave(
                                  provider.recentServiceMap[i]['serviceId'],
                                  provider.recentServiceMap[i]['title'],
                                  provider.recentServiceMap[i]['image'],
                                  provider.recentServiceMap[i]['price'],
                                  provider.recentServiceMap[i]['sellerName'],
                                  twoDouble(
                                      provider.recentServiceMap[i]['rating']),
                                  i,
                                  context);
                            },
                            isSaved:
                                provider.recentServiceMap[i]['isSaved'] == true
                                    ? true
                                    : false,
                          ),
                        )
                    ],
                  ),
                )
              : const Text("Something went wrong")
          : Container(),
    );
  }
}
