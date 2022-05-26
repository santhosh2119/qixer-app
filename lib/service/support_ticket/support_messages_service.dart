import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer/model/ticket_messages_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/view/utils/others_helper.dart';

class SupportMessagesService with ChangeNotifier {
  List messagesList = [];

  bool isloading = false;
  bool sendLoading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setSendLoadingTrue() {
    sendLoading = true;
    notifyListeners();
  }

  setSendLoadingFalse() {
    sendLoading = false;
    notifyListeners();
  }

  fetchMessages(ticketId) async {
    var connection = await checkConnection();
    if (connection) {
      messagesList = [];
      setLoadingTrue();
      //if connection is ok
      var response =
          await http.get(Uri.parse('$baseApi/view-ticket/$ticketId'));
      setLoadingFalse();

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['all_messages'].isNotEmpty) {
        var data = TicketMessageModel.fromJson(jsonDecode(response.body));

        setMessageList(data.allMessages);

        notifyListeners();
      } else {
        //Something went wrong

      }
    } else {
      OthersHelper()
          .showToast('Please check your internet connection', Colors.black);
    }
  }

  setMessageList(dataList) {
    for (int i = 0; i < dataList.length; i++) {
      messagesList.add({
        'id': dataList[i].id,
        'message': dataList[i].message,
        'notify': 'off',
        'attachment': null,
        'type': dataList[i].type,
      });
    }
    notifyListeners();
  }

//Send new message ======>

  sendMessage(ticketId, message) async {
    var data = jsonEncode({
      'ticket_id': ticketId,
      'user_type': 'buyer',
      'message': message,
    });
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var connection = await checkConnection();
    if (connection) {
      setSendLoadingTrue();
      //if connection is ok
      var response = await http.post(Uri.parse('$baseApi/ticket/message-send'),
          body: data, headers: header);
      setSendLoadingFalse();

      if (response.statusCode == 201) {
        print(response.body);
        addNewMessage(message);
        return true;
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
        print(response.body);
        return false;
      }
    } else {
      OthersHelper()
          .showToast('Please check your internet connection', Colors.black);
      return false;
    }
  }

  addNewMessage(newMessage) {
    messagesList.add({
      'id': '',
      'message': newMessage,
      'notify': 'off',
      'attachment': null,
      'type': 'buyer',
    });
    notifyListeners();
  }
}
