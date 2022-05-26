import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qixer/model/my_orders_list_model.dart';
import 'package:qixer/model/ticket_messages_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportMessagesService with ChangeNotifier {
  List messagesList = [];

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  fetchMessages(ticketId) async {
    //get user id

    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();
      //if connection is ok
      var response =
          await http.get(Uri.parse('$baseApi/view-ticket/$ticketId'));
      setLoadingFalse();

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['all_messages'].isNotEmpty) {
        var data = TicketMessageModel.fromJson(jsonDecode(response.body));

        messagesList = data.allMessages;

        notifyListeners();
      } else {
        setLoadingFalse();
        //Something went wrong

      }
    } else {
      OthersHelper()
          .showToast('Please check your internet connection', Colors.black);
    }
  }
}
