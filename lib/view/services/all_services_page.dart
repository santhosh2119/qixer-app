import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/view/services/components/service_filter_dropdowns.dart';
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
              //Dropdown ==========>
              const ServiceFilterDropdowns(),

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
                        pressed: () {},
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
