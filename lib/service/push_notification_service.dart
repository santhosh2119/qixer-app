// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/live_chat/chat_message_service.dart';

class PushNotificationService with ChangeNotifier {
  sendNotificationToSeller(BuildContext context,
      {required sellerId, required title, required body}) async {
    var pusherToken =
        Provider.of<ChatMessagesService>(context, listen: false).pusherToken;
    var pusherApiUrl =
        Provider.of<ChatMessagesService>(context, listen: false).pusherApiUrl;

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
          "Bearer A4EEE003A0AEB2B95F78FAD12EA11D8E1C281448DD8D9B33B47F6E5EC47CEDEA",
    };

    var data = jsonEncode({
      "interests": ["debug-seller$sellerId"],
      "fcm": {
        "notification": {"title": "$title", "body": "$body"}
      }
    });

    var response = await http.post(
        Uri.parse(
            'https://fcaf9caf-509c-4611-a225-2e508593d6af.pushnotifications.pusher.com/publish_api/v1/instances/fcaf9caf-509c-4611-a225-2e508593d6af/publishes'),
        headers: header,
        body: data);

    if (response.statusCode == 200) {
      print('send notification to seller success');
    } else {
      print('send notification to seller failed');
      print(response.body);
    }
  }
}
