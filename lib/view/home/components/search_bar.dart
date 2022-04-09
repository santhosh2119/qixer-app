import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constant_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      required this.searchController,
      required this.cc,
      required this.pressed})
      : super(key: key);

  final TextEditingController searchController;
  final ConstantColors cc;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 19),
        decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
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
              suffixIcon: SizedBox(
                width: 57,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 30,
                      width: 1.5,
                      color: cc.greyFive,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 35,
                      width: 35,
                      child: SvgPicture.asset('assets/svg/filter.svg'),
                    ),
                  ],
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(9)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              hintText: 'Search services...',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 18)),
        ));
  }
}
