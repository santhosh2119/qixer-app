import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/view/jobs/components/my_jobs_helper.dart';
import 'package:qixer/view/jobs/edit_job_page.dart';
import 'package:qixer/view/jobs/job_details_page.dart';

class MyJobsPopupMenu extends StatelessWidget {
  const MyJobsPopupMenu({
    Key? key,
    required this.jobId,
    required this.imageLink,
    required this.jobIndex,
  }) : super(key: key);

  final jobId;
  final imageLink;
  final jobIndex;

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
                    navigate(i, context, jobId, imageLink);
                  });
                },
                child: Text(popupMenuList[i]),
              ),
          ],
        )
      ],
    );
  }

  navigate(int i, BuildContext context, jobId, imageLink) {
    if (i == 0) {
      Provider.of<MyJobsService>(context, listen: false)
          .fetchJobDetails(jobId, context);
      Future.delayed(const Duration(microseconds: 500), () {
        return Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => JobDetailsPage(
              imageLink: imageLink,
            ),
          ),
        );
      });
    } else if (i == 1) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditJobPage(
            jobIndex: jobIndex,
          ),
        ),
      );
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
