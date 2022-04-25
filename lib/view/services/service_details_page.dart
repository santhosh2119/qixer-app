import 'package:flutter/material.dart';
import 'package:qixer/view/booking/booking_location_page.dart';
import 'package:qixer/view/services/components/about_seller_tab.dart';
import 'package:qixer/view/services/components/image_big.dart';
import 'package:qixer/view/services/components/overview_tab.dart';
import 'package:qixer/view/services/components/review_tab.dart';
import 'package:qixer/view/services/review/write_review_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../utils/common_helper.dart';
import 'components/service_details_top.dart';

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({Key? key}) : super(key: key);

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    // Image big
                    const ImageBig(
                      serviceName: 'Service Name',
                      imageLink:
                          'https://cdn.pixabay.com/photo/2018/10/01/13/53/droplet-3716288__340.jpg',
                    ),

                    //package price
                    ServiceDetailsTop(cc: cc),
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        onTap: (value) {
                          setState(() {
                            currentTab = value;
                          });
                        },
                        labelColor: cc.primaryColor,
                        unselectedLabelColor: cc.greyFour,
                        indicatorColor: cc.primaryColor,
                        unselectedLabelStyle: TextStyle(
                            color: cc.greyParagraph,
                            fontWeight: FontWeight.normal),
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Overview'),
                          Tab(text: 'About seller'),
                          Tab(text: 'Review'),
                        ],
                      ),
                      Container(
                        child: [
                          const OverviewTab(),
                          const AboutSellerTab(),
                          const ReviewTab(),
                        ][_tabIndex],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Book now button
          CommonHelper().dividerCommon(),
//Button
          sizedBox20(),

          Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Column(
                children: [
                  currentTab == 2
                      ? Column(
                          children: [
                            CommonHelper().borderButtonOrange("Write a review",
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const WriteReviewPage(),
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        )
                      : Container(),
                  CommonHelper().buttonOrange("Book Appointment", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const BookingLocationPage(),
                      ),
                    );
                  }),
                ],
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
