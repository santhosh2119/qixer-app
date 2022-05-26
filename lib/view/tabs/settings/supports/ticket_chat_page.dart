import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/support_ticket/support_messages_service.dart';
import 'package:qixer/view/tabs/settings/supports/support_ticket_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class TicketChatPage extends StatelessWidget {
  const TicketChatPage({Key? key, required this.title, required this.ticketId})
      : super(key: key);

  final String title;
  final ticketId;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    // List<ChatMessage> messages = [
    //   ChatMessage(messageContent: "Hi", messageType: "sender"),
    //   ChatMessage(messageContent: "I need help", messageType: "sender"),
    //   ChatMessage(
    //       messageContent:
    //           "Hello there, if you need any assistance, I am always here",
    //       messageType: "receiver"),
    //   ChatMessage(
    //       messageContent:
    //           "I placed an order 3 days ago.But I didn't receive my order yet",
    //       messageType: "sender"),
    //   ChatMessage(
    //       messageContent: "What is your order number", messageType: "receiver"),
    // ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: cc.greyParagraph,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: Container(
                //     padding: const EdgeInsets.all(5),
                //     decoration: const BoxDecoration(
                //         shape: BoxShape.circle, color: Colors.white),
                //     child: ClipRRect(
                //       child: Image.asset(
                //         'assets/images/logo.png',
                //       ),
                //     ),
                //   ),
                //   maxRadius: 22,
                // ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "#$ticketId",
                        style: TextStyle(color: cc.primaryColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                // Icon(
                //   Icons.settings,
                //   color: Colors.black54,
                // ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<SupportMessagesService>(
        builder: (context, provider, child) => Stack(
          children: <Widget>[
            provider.isloading == false
                ?
                //chat messages
                ListView.builder(
                    itemCount: provider.messagesList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment:
                            provider.messagesList[index].type == "seller"
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                        children: [
                          //small show profile pic
                          provider.messagesList[index].type == "seller"
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    left: 13,
                                  ),
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: ClipRRect(
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                    ),
                                  ),
                                )
                              : Container(),
                          //the message
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: provider.messagesList[index].type ==
                                          "seller"
                                      ? 90
                                      : 10,
                                  right: provider.messagesList[index].type ==
                                          "seller"
                                      ? 90
                                      : 10,
                                  top: 10,
                                  bottom: 10),
                              child: Align(
                                alignment: (provider.messagesList[index].type ==
                                        "seller"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (provider.messagesList[index].type ==
                                            "seller"
                                        ? Colors.grey.shade200
                                        : cc.primaryColor),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    SupportTicketHelper().removePTag(
                                        provider.messagesList[index].message),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: (provider
                                                    .messagesList[index].type ==
                                                "seller"
                                            ? Colors.grey[800]
                                            : Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          provider.messagesList[index].type == "seller"
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    right: 13,
                                  ),
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      'https://cdn.pixabay.com/photo/2016/09/08/13/58/desert-1654439__340.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    },
                  )
                : OthersHelper().showLoading(cc.primaryColor),
            //write message section
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, bottom: 10, top: 10, right: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: cc.primaryColor,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ChatMessage {
//   String messageContent;
//   String messageType;
//   ChatMessage({required this.messageContent, required this.messageType});
// }
