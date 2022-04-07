import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            //name and profile image
            Row(
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

            //Search bar ========>
            Container(
                margin: const EdgeInsets.only(bottom: 19),
                decoration: BoxDecoration(
                    color: const Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 14),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 19.0,
                            width: 40.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/search.png'),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      suffixIcon: Container(
                        height: 11.0,
                        width: 40.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/filter.png'),
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(9)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: 'Search services...',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 18)),
                )),

            // Container(
            //     width: double.infinity,
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
            //     decoration: BoxDecoration(
            //         color: Colors.grey.withOpacity(.1),
            //         borderRadius: BorderRadius.circular(5)),
            //     child: Row(
            //       children: const [
            //         Icon(
            //           Icons.search,
            //           color: Colors.grey,
            //           size: 22,
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           'Search services...',
            //           style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 14,
            //           ),
            //         ),
            //       ],
            //     )),
          ]),
        ),
      ),
    );
  }
}
