import 'package:flutter/material.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              clipBehavior: Clip.none,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    CommonHelper().titleCommon('Saved services'),
                    const SizedBox(
                      height: 22,
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < 2; i++)
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ServiceCard(
                              cc: cc,
                              imageLink:
                                  "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                              rating: '4.5',
                              title:
                                  'Hair cutting service at low price Hair cutting',
                              sellerName: 'Jane Cooper',
                              price: '30',
                              buttonText: 'Book Now',
                              width: double.infinity,
                              marginRight: 0.0,
                            ),
                          ),
                      ],
                    )

                    //
                  ]),
            ),
          ),
        ));
  }
}
