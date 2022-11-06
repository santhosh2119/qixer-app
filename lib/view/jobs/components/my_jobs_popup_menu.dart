import 'package:flutter/material.dart';

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
            PopupMenuItem(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => const MyJobsPage(),
                  //   ),
                  // );
                });
              },
              child: Text(popupMenuList[0]),
            ),
            PopupMenuItem(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => const MyJobsPage(),
                  //   ),
                  // );
                });
              },
              child: Text(popupMenuList[1]),
            ),
            PopupMenuItem(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => const MyJobsPage(),
                  //   ),
                  // );
                });
              },
              child: Text(popupMenuList[2]),
            ),
          ],
        )
      ],
    );
  }
}
