import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/jobs/components/my_jobs_card.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({Key? key}) : super(key: key);

  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('My Jobs', context, () {
        Navigator.pop(context);
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              clipBehavior: Clip.none,
              child: Consumer<AppStringService>(
                builder: (context, asProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxCustom(10),
                      Column(
                        children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: cc.borderColor),
                                  borderRadius: BorderRadius.circular(9)),
                              padding: const EdgeInsets.fromLTRB(13, 15, 13, 8),
                              child: Column(
                                children: [
                                  MyJobsCardContents(
                                    cc: cc,
                                    imageLink: placeHolderUrl,
                                    title: 'This is title',
                                    sellerName: 'saleheen',
                                    price: 100,
                                  ),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  CommonHelper().dividerCommon(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            AutoSizeText(
                                              '${asProvider.getString('Starts from')}:',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    cc.greyFour.withOpacity(.6),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Consumer<RtlService>(
                                              builder: (context, rtlP, child) =>
                                                  Expanded(
                                                child: AutoSizeText(
                                                  rtlP.currencyDirection ==
                                                          'left'
                                                      ? '${rtlP.currency}100'
                                                      : '100${rtlP.currency}',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: cc.greyFour,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      //on off button
                                      const SwitchButton(switchOn: true)
                                    ],
                                  )
                                ],
                              ),
                            )
                        ],
                      )

                      //
                    ]),
              )),
        ),
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  const SwitchButton({Key? key, required this.switchOn}) : super(key: key);

  final bool switchOn;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Switch(
      // This bool value toggles the switch.
      value: widget.switchOn,
      activeColor: cc.successColor,
      onChanged: (bool value) {},
    );
  }
}
