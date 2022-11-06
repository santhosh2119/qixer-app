import 'package:flutter/material.dart';
import 'package:qixer/view/jobs/components/my_jobs_helper.dart';
import 'package:qixer/view/jobs/job_details_page.dart';

class MyJobsPopupMenu extends StatelessWidget {
  const MyJobsPopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List popupMenuList = ['View', 'Edit', 'Delete'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            for (int i = 0; i < popupMenuList.length; i++)
              PopupMenuItem(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    navigate(i, context);
                  });
                },
                child: Text(popupMenuList[i]),
              ),
          ],
        )
      ],
    );
  }

  navigate(int i, BuildContext context) {
    if (i == 0) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const JobDetailsPage(),
        ),
      );
    } else if (i == 1) {
      // return Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => const JobConversationPage(
      //       title: 'Those medals you wear on your moth',
      //       jobId: '1',
      //     ),
      //   ),
      // );
    } else if (i == 2) {
      MyJobsHelper().deletePopup(context);
    } else if (i == 3) {
// return Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => const JobDetailsPage(),
//         ),
//       );
    }
  }
}
