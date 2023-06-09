import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/home/categories/components/category_card.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.cc,
    required this.asProvider,
  }) : super(key: key);
  final ConstantColors cc;
  final asProvider;
  @override
  Widget build(BuildContext context) {
    // getLineAwsome("las la-charging-station");
    return Consumer<CategoryService>(
      builder: (context, provider, child) {
        return provider.categories != null
            ? provider.categories != 'error'
                ? GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                    ),
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0;
                          i < provider.categories.category.length;
                          i++)
                        CategoryCard(
                          name: provider.categories.category[i].name,
                          id: provider.categories.category[i].id,
                          cc: cc,
                          index: i,
                          marginRight: 0.17,
                          imagelink: provider.categories.category[i].mobileIcon,
                        )
                    ],
                  )
                : Text(asProvider.getString('Something went wrong'))
            : OthersHelper().showLoading(cc.primaryColor);
      },
    );
  }
}
