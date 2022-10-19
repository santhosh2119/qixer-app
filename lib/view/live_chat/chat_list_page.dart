import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/live_chat/chat_list_service.dart';
import 'package:qixer/service/support_ticket/support_messages_service.dart';
import 'package:qixer/view/live_chat/chat_message_page.dart';
import 'package:qixer/view/live_chat/components/chat_search.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Consumer<ChatListService>(
              builder: (context, provider, child) => provider
                      .chatList.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 20, bottom: 20),
                                  child: const Icon(Icons.arrow_back_ios)),
                            ),
                            const Text(
                              "Conversations",
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        //Search bar

                        const SizedBox(
                          height: 10,
                        ),

                        const ChatSearch(),

                        const SizedBox(
                          height: 20,
                        ),

                        for (int i = 0; i < provider.chatList.length; i++)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ChatMessagePage(
                                    title: provider.chatList[i].sellerList.name,
                                    buyerId: 1,
                                    sellerId: 1,
                                  ),
                                ),
                              );

                              //fetch message
                              Provider.of<SupportMessagesService>(context,
                                      listen: false)
                                  .fetchMessages(21);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  provider.chatList[i]
                                                          .senderProfileImage ??
                                                      placeHolderUrl),
                                              maxRadius: 25,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      provider.chatList[i]
                                                          .sellerList.name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CommonHelper().dividerCommon()
                              ],
                            ),
                          ),

                        // ==============>
                        //
                      ],
                    )
                  : SizedBox(
                      height: screenHeight - 200,
                      child: OthersHelper().showLoading(cc.primaryColor),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
