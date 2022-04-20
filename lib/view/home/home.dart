import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/home_services/slider_service.dart';
import 'package:qixer/view/home/components/categories.dart';
import 'package:qixer/view/home/components/discounts.dart';
import 'package:qixer/view/home/components/slider_home.dart';
import 'package:qixer/view/home/components/top_rated_sellers.dart';
import 'package:qixer/view/services/all_services_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../utils/constant_styles.dart';
import 'components/search_bar.dart';
import 'components/section_title.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Provider.of<SliderService>(context, listen: false).loadSlider();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              //name and profile image
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    //name
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            color: cc.greyParagraph,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Lesile Alexander',
                          style: TextStyle(
                            color: cc.greyFour,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),

                    //profile image
                    CommonHelper().profileImage(
                        "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                        52,
                        52)
                  ],
                ),
              ),

              //Search bar ========>
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SearchBar(
                  cc: cc,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              CommonHelper().dividerCommon(),
              const SizedBox(
                height: 25,
              ),

              //Slider
              Consumer<SliderService>(
                  builder: (context, provider, child) =>
                      provider.sliderImageList.isNotEmpty
                          ? SliderHome(
                              cc: cc,
                              sliderDetailsList: provider.sliderDetailsList,
                              sliderImageList: provider.sliderImageList,
                            )
                          : Container()),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    //see all ============>
                    const SizedBox(
                      height: 25,
                    ),
                    SectionTitle(
                      cc: cc,
                      title: 'Browse categories',
                      pressed: () {},
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    //Categories =============>
                    Categories(
                      cc: cc,
                    ),

                    //Top rated sellers ========>
                    const SizedBox(
                      height: 25,
                    ),
                    SectionTitle(
                      cc: cc,
                      title: 'Top rated sellers',
                      pressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AllServicePage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    TopRatedSellers(cc: cc),

                    //Discount images
                    const SizedBox(
                      height: 25,
                    ),
                    Discounts(cc: cc),

                    //Top rated sellers ========>
                    const SizedBox(
                      height: 30,
                    ),
                    SectionTitle(
                      cc: cc,
                      title: 'Recently listed',
                      pressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AllServicePage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    TopRatedSellers(cc: cc),

                    //Discount images
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
