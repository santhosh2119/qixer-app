import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/support_ticket/create_ticket_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';

import '../../../booking/components/textarea_field.dart';

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({Key? key}) : super(key: key);

  @override
  _CreateTicketPageState createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Create ticket', context, () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenPadding, vertical: 20),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonHelper().labelCommon("Title"),
                  CustomInput(
                    controller: titleController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ticket title';
                      }
                      return null;
                    },
                    hintText: "Ticket title",
                    // icon: 'assets/icons/user.png',
                    paddingHorizontal: 18,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonHelper().labelCommon("Description"),
                  TextareaField(
                    hintText: 'Please explain your problem',
                    notesController: descController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<CreateTicketService>(
                      builder: (context, ctProvider, child) => Column(
                            children: [
                              //pick image button =====>
                              CommonHelper().buttonOrange('Choose images', () {
                                ctProvider.pickImage(context);
                              }),
                              ctProvider.pickedImage != null
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: ListView(
                                            clipBehavior: Clip.none,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            children: [
                                              // for (int i = 0;
                                              //     i <
                                              //         btProvider
                                              //             .images!.length;
                                              //     i++)
                                              InkWell(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Image.file(
                                                        // File(provider.images[i].path),
                                                        File(ctProvider
                                                            .pickedImage.path),
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          )),

                  //Save button =========>

                  const SizedBox(
                    height: 30,
                  ),
                  CommonHelper().buttonOrange(
                    'Create ticket',
                    () {},
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}
