import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/report_services/report_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class MyReportsList extends StatefulWidget {
  const MyReportsList({Key? key}) : super(key: key);

  @override
  _MyReportsListState createState() => _MyReportsListState();
}

class _MyReportsListState extends State<MyReportsList> {
  @override
  void initState() {
    super.initState();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: cc.greyPrimary),
          title: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Text(
              asProvider.getString('Reports'),
              style: TextStyle(
                  color: cc.greyPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
          // actions: [
          //   Consumer<AppStringService>(
          //     builder: (context, asProvider, child) => Container(
          //       width: screenWidth / 4,
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 9,
          //       ),
          //       child: InkWell(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute<void>(
          //               builder: (BuildContext context) =>
          //                   const CreateTicketPage(),
          //             ),
          //           );
          //         },
          //         child: Container(
          //             // width: double.infinity,

          //             alignment: Alignment.center,
          //             // padding: const EdgeInsets.symmetric(vertical: 10),
          //             decoration: BoxDecoration(
          //                 color: cc.primaryColor,
          //                 borderRadius: BorderRadius.circular(8)),
          //             child: AutoSizeText(
          //               asProvider.getString('Create'),
          //               maxLines: 1,
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 13,
          //               ),
          //             )),
          //       ),
          //     ),
          //   ),
          //   const SizedBox(
          //     width: 25,
          //   ),
          // ],
        ),
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown:
              context.watch<ReportService>().currentPage > 1 ? false : true,
          onRefresh: () async {
            final result =
                await Provider.of<ReportService>(context, listen: false)
                    .fetchReportList(context);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result =
                await Provider.of<ReportService>(context, listen: false)
                    .fetchReportList(context);
            if (result) {
              debugPrint('loadcomplete ran');
              //loadcomplete function loads the data again
              refreshController.loadComplete();
            } else {
              debugPrint('no more data');
              refreshController.loadNoData();

              Future.delayed(const Duration(seconds: 1), () {
                //it will reset footer no data state to idle and will let us load again
                refreshController.resetNoData();
              });
            }
          },
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<AppStringService>(
              builder: (context, asProvider, child) => Consumer<ReportService>(
                  builder: (context, provider, child) => provider
                          .reportList.isNotEmpty
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: screenPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < provider.reportList.length;
                                  i++)
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 3,
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 15, 15, 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: cc.borderColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Ticket title

                                        Row(
                                          children: [
                                            Expanded(
                                              // width: screenWidth - 200,
                                              child: CommonHelper().labelCommon(
                                                'Report id: ' +
                                                    provider.reportList[i]['id']
                                                        .toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: CommonHelper()
                                                  .buttonOrange('Chat admin',
                                                      () {
                                                provider.goToMessagePage(
                                                    context,
                                                    provider.reportList[i]
                                                        ['subject'],
                                                    provider.reportList[i]
                                                        ['id']);
                                              }, paddingVerticle: 10),
                                            )
                                          ],
                                        ),
                                        CommonHelper().labelCommon(
                                          'Order id: ' +
                                              provider.reportList[i]['orderId']
                                                  .toString(),
                                        ),
                                      ]),
                                )
                            ],
                          ),
                        )
                      : CommonHelper().nothingfound(
                          context, asProvider.getString('No Report'))),
            ),
          ),
        ));
  }
}
