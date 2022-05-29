import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/ticket_list_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/support_ticket/support_messages_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/tabs/settings/supports/ticket_chat_page.dart';

class SupportTicketService with ChangeNotifier {
  var ticketList = [];

  late int totalPages;
  int currentPage = 1;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  fetchTicketList(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      ticketList = [];
      notifyListeners();

      Provider.of<SupportTicketService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {}

    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      //TODO change userId here
      var response = await http
          .get(Uri.parse("$baseApi/support-tickets/$userId?page=$currentPage"));

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['tickets']['data'].isNotEmpty) {
        var data = TicketListModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.tickets.lastPage);

        if (isrefresh) {
          print('refresh true');
          //if refreshed, then remove all service from list and insert new data
          //make the list empty first so that existing data doesn't stay
          setServiceList(data.tickets.data, false);
        } else {
          print('add new data');

          //else add new data
          setServiceList(data.tickets.data, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        return false;
      }
    }
  }

  setServiceList(dataList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      ticketList = [];
      notifyListeners();
    }

    ticketList = dataList;
    notifyListeners();
  }

  goToMessagePage(BuildContext context, title, id) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => TicketChatPage(
          title: title,
          ticketId: id,
        ),
      ),
    );

    //fetch message
    Provider.of<SupportMessagesService>(context, listen: false)
        .fetchMessages(id);
  }
}