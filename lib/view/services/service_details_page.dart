import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:measured_size/measured_size.dart';
import 'package:qixer/view/booking/booking_location_page.dart';
import 'package:qixer/view/services/components/about_seller_tab.dart';
import 'package:qixer/view/services/components/image_big.dart';
import 'package:qixer/view/services/components/overview_tab.dart';
import 'package:qixer/view/services/components/review_tab.dart';
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

                    //Tab bar
                    // Container(
                    //   color: Colors.white,
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   margin: const EdgeInsets.only(top: 20),
                    //   child: DefaultTabController(
                    //       length: 3, // length of tabs
                    //       initialIndex: 0,
                    //       child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.stretch,
                    //           children: <Widget>[
                    //             TabBar(
                    //               labelColor: cc.primaryColor,
                    //               unselectedLabelColor: cc.greyFour,
                    //               indicatorColor: cc.primaryColor,
                    //               unselectedLabelStyle: TextStyle(
                    //                   color: cc.greyParagraph,
                    //                   fontWeight: FontWeight.normal),
                    //               tabs: const [
                    //                 Tab(text: 'Overview'),
                    //                 Tab(text: 'About seller'),
                    //                 Tab(text: 'Review'),
                    //               ],
                    //             ),
                    //             const SizedBox(
                    //                 height: 500,
                    //                 child: TabBarView(children: <Widget>[
                    //                   OverviewTab(),
                    //                   AboutSellerTab(),
                    //                   ReviewTab(),
                    //                 ]))
                    //           ])),
                    // ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      TabBar(
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
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: CommonHelper().buttonOrange("Book Appointment", () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const BookingLocationPage(),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
