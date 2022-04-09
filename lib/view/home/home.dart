import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qixer/view/home/components/slider_home.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import 'components/search_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                      placeholder: (context, url) {
                        return Image.asset('assets/images/placeholder.png');
                      },
                      height: 52,
                      width: 52,
                      fit: BoxFit.cover,
                    ),
                  )
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
                  searchController: searchController, cc: cc, pressed: () {}),
            ),

            const Divider(
              thickness: 1.5,
              color: Color(0xffEAECF0),
            ),
            const SizedBox(
              height: 15,
            ),

            //Slider
            SliderHome(cc: cc),
          ]),
        ),
      ),
    );
  }
}
