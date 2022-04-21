import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class TopRatedServices extends StatelessWidget {
  const TopRatedServices({
    Key? key,
    required this.cc,
  }) : super(key: key);
  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRatedServicesSerivce>(
      builder: (context, provider, child) => provider.topService != null
          ? provider.topService != 'error'
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 190,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0;
                          i < provider.topService.topServices.length;
                          i++)
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
                            imageLink: provider.imageList[i],
                            rating: provider.ratingList[i].toString(),
                            title: provider.topService.topServices[i].title,
                            sellerName: provider
                                .topService.topServices[i].sellerForMobile.name,
                            price: provider.topService.topServices[i].price,
                            buttonText: 'Book Now',
                            width: MediaQuery.of(context).size.width - 85,
                            marginRight: 17.0,
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
